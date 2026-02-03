// Compiled with Typst 0.13.1
#import "../../template_zusammenf.typ": *
#import "@preview/codelst:2.0.2": sourcecode

#show: project.with(
  // authors: ("Nina Grässli", "Jannis Tschan", "Jasmin Fässler"),
  // fach: "MsTe",
  // fach-long: ".NET Technologien",
  // semester: "HS25",
  // language: "de",
  // tableofcontents: (enabled: true, depth: 2, columns: 2),
  font-size: 10pt,
)

// Global configuration
#set grid(columns: (1fr, 1fr), gutter: 1em)
#show grid: set par(justify: false, linebreaks: "optimized")
#set figure(supplement: none)

// Set styles for the gRPC example code blocks
#let code-example(body) = {
  // sourcecode uses a table internally, the template styles the first row with emph, disable here
  show emph: set text(fill: black, style: "italic", weight: "regular")
  set text(
    size: 0.88em, 
    top-edge: 0.98em
  )
  

  sourcecode(lang: "cs", body, frame: none)
}





=== Beispiel: File Streaming Service
==== Client (`Program.cs`)
#code-example(
  ```cs
  using AsyncClientStreamingCall<FileDto, Empty> call = client.SendFiles();
  
  // The port number(5001) must match the port of the gRPC server.
  GrpcChannel channel = GrpcChannel.ForAddress("https://localhost:5001");
  StreamingService.StreamingClient client = new(channel); // Client that every function uses
  
  // Run all streaming functions
  await TestServerStreaming(client); await TestClientStreaming(client); await TestBiDirectionalStreaming(client);
  WriteLine("Press any key to exit..."); ReadKey();
  
  // Stream files from server
  static async Task TestServerStreaming(StreamingService.StreamingClient client) {
      WriteLine(nameof(TestServerStreaming));
      using AsyncServerStreamingCall<FileDto> call = client.ReadFiles(new()); // Call object without Parameter
      await foreach (FileDto message in call.ResponseStream.ReadAllAsync()) { // Read last written chunk
          WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
      }
  }
  
  // Stream files to server
  static async Task TestClientStreaming(StreamingService.StreamingClient client) {
    WriteLine(nameof(TestClientStreaming));
    string[] files = Directory.GetFiles(@"Files"); // Get all files in folder
    foreach (string file in files) { // Open every file
        string content; int line = 0; using StreamReader reader = File.OpenText(file);
        while ((content = await reader.ReadLineAsync()) != null) {
            line++; // Read every line
            FileDto reply = new() { FileName = file, Line = line, Content = content, }; // Write into Protobuf
            await call.RequestStream.WriteAsync(reply); // Write protobuf to stream
        }
    }
    // Closing the stream is required
    await call.RequestStream.CompleteAsync(); // No more messages to come (server exits foreach-Loop)
    Empty result = await call; // Wait until service method is terminated / Get the result
  }
  
  // Send and receive files at the same time
  static async Task TestBiDirectionalStreaming(StreamingService.StreamingClient client) {
    WriteLine(nameof(TestBiDirectionalStreaming));
    using AsyncDuplexStreamingCall<FileDto, FileDto> call = client.RoundtripFiles();
    // Read
    Task readTask = Task.Run(async () => {
        await foreach (FileDto message in call.ResponseStream.ReadAllAsync()) {
            WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
        }
    });
    // Write
    string[] files = Directory.GetFiles(@"Files");
    foreach (string file in files) {
        string content; int line = 0; using StreamReader reader = File.OpenText(file);
        while ((content = await reader.ReadLineAsync()) != null) {
            line++;
            FileDto reply = new() { FileName = file, Line = line, Content = content, };
            await call.RequestStream.WriteAsync(reply);
        }
    }
    // Required
    await call.RequestStream.CompleteAsync(); // No more messages to come (server exits foreach-Loop)
    await readTask; // Wait until service method is terminated / all messages are received by client
  }
  ```,
)

#pagebreak()
==== Server
#code-example(
  ```cs
  public class StreamingService : FileStreamingService.FileStreamingServiceBase {
      // Read files from disk and send to the client
      public override async Task ReadFiles(
        Empty request, // No parameters
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
        Empty request, // No parameters
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
          WriteLine(nameof(ReadFiles));
          string[] files = Directory.GetFiles(@"..\11_FileStreamingFiles");
  
          foreach (string file in files) {
              string content; int line = 0;
              using StreamReader reader = File.OpenText(file);
  
              // Read until End of File
              while ((content = await reader.ReadLineAsync()) != null) {
                  line++;
                  FileDto reply = new() { FileName = file, Line = line, Content = content, };
                  await responseStream.WriteAsync(reply);
              }
          }
      }
  
      // Receive files that the client sends
      public override async Task<Empty> SendFiles(
        IAsyncStreamReader<FileDto> requestStream,
        ServerCallContext context)
      {
          WriteLine(nameof(SendFiles));
          await foreach (FileDto message in requestStream.ReadAllAsync()) { // Read last written chunk
              WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
          }
          return new Empty(); // Empty result, nothing to return
      }
  
      // Send files back to the client
      public override async Task RoundtripFiles(
        IAsyncStreamReader<FileDto> requestStream,
        IServerStreamWriter<FileDto> responseStream,
        ServerCallContext context)
      {
          WriteLine(nameof(RoundtripFiles));
          await foreach (FileDto message in requestStream.ReadAllAsync()) {
              await responseStream.WriteAsync(message);
              WriteLine($"File: {message.FileName}, Line Nr: {message.Line}, Content: {message.Content}");
          }
      }
  }
  ```,
)
==== Proto
#code-example(
  ```proto
  syntax = "proto3";
  import "google/protobuf/empty.proto";
  option csharp_namespace = "FileStreaming";
  package FileStreaming;
  
  service StreamingService {
    rpc ReadFiles (google.protobuf.Empty) returns (stream FileDto);
    rpc SendFiles (stream FileDto) returns (google.protobuf.Empty);
    rpc RoundtripFiles (stream FileDto) returns (stream FileDto);
  }
  
  message FileDto {
    string file_name = 1;
    int32 line = 2;
    string content = 3;
  }
  ```,
)
