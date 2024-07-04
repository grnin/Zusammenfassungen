// Compiled with Typst 0.11.1
#import "../template_zusammenf.typ": *
#import "@preview/wrap-it:0.1.0": wrap-content

#show: project.with(
  authors: ("Nina Grässli", "Jannis Tschan"),
  fach: "AIAp",
  fach-long: "AI Applications",
  semester: "FS24",
  language: "en",
  font-size: 10pt,
  tableofcontents: (enabled: true, depth: 3, columns: 2)
)

= Artificial Neural Network (ANN)
An ANN is a machine learning model inspired by the structure and function of animal brains.
It consists of _neurons_ inside a _layer_. Neurons receive, process and send signals to other
neurons in the next layer. The output is computed by some non-linear function of the sum of its
inputs, the _activation function_. The strength of the signal at each connection is determined
by a _weight_, which adjusts during the learning process. Signals travel from the _input layer_
to the _output layer_, while possibly passing through multiple intermediate layers, the _hidden
layers_.

#image("img/aiap_1.png", width: 75%)
#tcolor("rot", "3")-dimensional input $x_n$, hidden layer with #tcolor("grün", "2") neurons,
output layer with #tcolor("orange", "1") neuron. The sum of all inputs with its weights $W_n$
for each input is added to a bias $b$ before it is passed to the corresponding neuron.\
_Trainable parameters:_ $fxcolor("grün", 2) dot (fxcolor("rot", 3) "weights" + 1 "bias") +
fxcolor("orange", 1) dot (fxcolor("grün", 2) "weights" + 1 "bias") = 11 "parameters"$


= Large Language Model (LLM)
A LLM is a _huge ANN_ with a _particular structure_ that is much more complicated.
A LLM generates text _sequentially_ #hinweis[(word-by-word or token-by-token)].
The output is not a word, but a _probability distribution over a dictionary_.
The next word is sampled according to this distribution and is the most "plausible" according to
the model. _auto-regressive:_ each output is added to the input-context.
So the generation of each next word takes into account the entire sequence generated so far.\
The _knowledge of an LLM_ is represented in the _weights_ and the _network structure_.
Data is not stored explicitly.

== Prompt Engineering
A LLM performs better when it has access to _more context_. A general, open ended prompt will
produce a worse output than one that provides information about the _starting point_ and the
_desired result_, often divided in the categories
_Role_ #hinweis[(who the LLM should be, i.e a cook)],
_Context_ #hinweis[(what it has access to, i.e. what ingredients)],
_Constraints_ #hinweis[(what it should pay attention to i.e. a healthy, low fat diet)] and
_Instruction_ #hinweis[(what output it should produce, i.e. a recipe)].
This is called _prompt engineering_. By providing information not present at training time,
the LLM will generate a _more specific/reliable output_. An LLMs process of responding to
prompts using provided data or context is called _augmented generation_.

*Retrieval Augmented Generation (RAG):* 
Let the LLM _access a data source_ by uploading files or writing prompts that hint the LLM to
send a query to a search engine. Also called _context-aware LLM_. Use cases: Searching internal,
new #hinweis[(post-training)] or domain-specific data. A popular RAG architecture is LlamaIndex.

== Open Source LLMs
Many open source models are available. Two popular models are _LLaMA2_ by Meta and _Mistral_.
Models are basically defined by two files:
_model.py_ #hinweis[(small code file that defines the structure of the LLM and runs it)] and
_weights.pkl_ #hinweis[(potentially huge file with the parameters. Sometimes called a "checkpoint")].

== Working with your own LLM
Enhances _security_, protects private/internal data.
Depending on use-case: _Lower costs_, develop a _domain-expert model_ on your own data.
You can do this by _fine-tuning_ a pre-trained model #hinweis[(expensive training, new data
requires new fine-tuning)] or with _RAG_.

== Multimodal AI
_Modality:_ The way something is expressed or perceived #hinweis[(human senses, images, videos, sound)].
_Multimodal:_ involving several ways of operating or dealing with something.
A multimodal AI integrates different modes of data. Internally, different modes are mapped onto
similar representations #hinweis[(image, text, voice representing a tree)].

#pagebreak()

= Technology Ethics
*Problems of AI:*
Energy consumption, Few players controlling huge market, Conflict of Interest, Deskilling of moral decisions\
*DIKW Pyramid:*
_Data_ #hinweis[(Discrete, objective facts about an event)],
_Information_ #hinweis[(Data with analyzed relationships and connections)],
_Knowledge_ #hinweis[(Contextualized Information)],
_Wisdom_ #hinweis[(This is the top of the pyramid)].
These four layers lead to real-world decision making.

== Technology Ethics
_Application of ethical thinking to the practical concerns of technology._
Take actions that are voluntarily constrained by our judgement -- our ethics.

=== 16 Challenges and Opportunities 
#grid(columns: (1fr, 1fr, 1fr), gutter: 1em, [
  + Technical Safety
  + Transparency and Privacy
  + Beneficial Use & Capacity for Good
  + Malicious Use & Capacity for Evil
  + Bias in Data, Training Sets, etc.
  + Unemployment / Lack of Purpose
], [
  7. Growing Inequality
  + Environmental Effects
  + Automating Ethics
  + Moral Deskilling & Debility
  + AI Consciousness, "Robot Rights"
], [
  12. AGI and Superintelligence
  + Dependency on AI
  + AI-powered Addiction
  + Isolation and Loneliness
  + Effects on the Human Spirit
])

== 6 Ethical Lenses
_The Rights Lens_ #hinweis[(Focuses on protecting individual moral rights based on human dignity and autonomy)],
_The Justice Lens_ #hinweis[(Ensures fair and equal treatment based on merit or need, addressing various types of justice.)], 
_The Utilitarian Lens_ #hinweis[(Evaluates actions by their consequences, aiming for the greatest good for the most people.)]
_The Common Good Lens_ #hinweis[(Promotes actions that contribute to societal welfare and the well-being of all community members)], 
_The Virtue Lens_ #hinweis[(Emphasizes actions aligned with ideal virtues fostering personal development and character)] and 
_The Care Ethics Lens_ #hinweis[(Prioritizes empathy and compassion in relationships, considering stakeholders' feelings and contexts)].


/*
#grid(columns: (1fr, 1fr), gutter: 1em, [
  === The Rights Lens
  The rights lens focuses on _protecting and respecting the moral rights of individuals_,
  which are grounded in _human dignity and autonomy_. It emphasizes treating people as ends in
  themselves, not merely as means to an end. _Moral rights_ include making one's own life
  choices, being told the truth, and having privacy.
  
  === The Justice Lens
  The justice lens is about giving each person their due based on _fair and equal treatment_,
  which can vary by merit or need. Different types of justice include social, distributive,
  corrective, retributive, and restorative justice, addressing various contexts of _fairness_.
  It aims to ensure everyone receives what they are rightfully entitled to.
  
  === The Utilitarian Lens
  Utilitarianism evaluates the ethicality of actions based on their _consequences_, aiming to
  produce the _greatest balance of good over harm_ for the _most people_. It involves careful
  analysis of the impacts on all stakeholders, such as customers, employees, and the community.
  This lens often uses _cost/benefit analysis_ to guide decisions.
],[
  === The Common Good Lens
  The common good lens asserts that ethical actions contribute to the _welfare and interlocking
  relationships of society_. It stresses mutual concern for shared interests and the importance
  of common conditions like clean air, public health, and education. This approach values 
  _community life and the well-being of all members_.
  
  === The Virtue Lens
  Virtue ethics emphasizes actions consistent with ideal virtues that foster human development,
  such as _honesty, courage, and integrity_. It asks what kind of person one will become by
  performing certain actions, focusing on _acting according to the highest potential_ of one's
  character. This lens is about _aligning actions with virtuous traits_.
  
  === The Care Ethics Lens
  Care ethics prioritizes _relationships_ and responding to individuals' specific circumstances
  with _empathy_ and _compassion_. It values interdependence and seeks to understand the
  _feelings and viewpoints_ of all stakeholders. This lens advocates for resolutions that
  consider the relational context and societal duties, promoting a holistic approach to ethical conflicts.
])
*/
*Problems in using the lenses:* 
We may _not agree_ on the _content_ of these lenses, not everyone has the same set of civil
rights for example. _Different lenses_ may lead to _different answers_ to the question
"What is ethical?".\
*Framework for Ethical Decision Making:*
_Identify the Ethical Issues:_ #hinweis[(Determine if the decision could harm or unfairly
benefit someone or a group)],
_Get the Facts_ #hinweis[(relevant information, stakeholders, explore possible actions)],
_Evaluate Alternative Actions_ #hinweis[(Use the lenses for this)],
_Choose an option for action and test it_ #hinweis[(select best option, plan carefully)] and finally
_Implement your decision and reflect on the outcome_ #hinweis[(review results, identify
follow-up actions)]

/*
== Framework for Ethical Decision Making
+ _Identify the Ethical Issues:_ Determine if the decision could harm or unfairly benefit
  someone or a group, Consider if the issue is beyond legal or efficiency concerns, involving moral choices.
+ _Get the Facts:_ Gather all relevant information, and identify any unknowns.
  Recognize the stakeholders and assess whose concerns are most important.
  Explore all possible actions and consult with relevant parties to find creative options.
+ _Evaluate Alternative Actions:_ Use the lenses. 
  *Rights Lens:* Which option respects everyone's rights? 
  *Justice Lens:* Which option is the fairest? 
  *Utilitarian Lens:* Which option produces the most good and least harm? 
  *Common Good Lens:* Which option benefits the community as a whole? 
  *Virtue Lens:* Which option aligns with the virtues I want to embody? 
  *Care Ethics Lens:* Which option considers relationships and stakeholder concerns?
+ _Choose an Option for Action and Test it:_ Select the best option after thorough evaluation.
  Consider the perspective of a respected person or public audience on your choice.
  Plan the implementation carefully, ensuring stakeholder concerns are addressed.
+ _Implement Your Decision and Reflect on the Outcome:_ Execute the decision and review its
  results. Reflect on what was learned and identify any necessary follow-up actions.
*/


= Image classification
Image classification is one of the main tasks of _supervised learning_, where training data
consisting of an image with a label of its content is used for training.
The trained model can then predict the most likely label when given an image.
It requires 4 things: _Data_, a _loss function_ #hinweis[(typically a probabilistic loss like
`SparseCategoricalCrossentropy`)], a _model_ and an _optimizer_ #hinweis[(`Adam`, an improved 
version of Stochastic Gradient Descent)]

== Example Architecture
- _Input:_ The pixel values of a 2D image are "flattened" into a column vector
  #hinweis[($1 times n$ vector)] and fed to the hidden layers of an ANN.
- _Output:_ The ANN has one output neuron per class. Each neuron "votes" for its class.
  The more active a neuron is, the more likely the input belongs to this class.

#image("img/aiap_3.png", width: 70%)

== Terminology
- _The Convolution Operation:_
  Involves applying a filter (kernel) to input data to create a feature map,
  detecting patterns like edges in images.
- _Logits:_
  A vector of non-normalized predictions that a classification model generates.
  Typically passed to a softmax function to generate percentages.
- _Kernel, Filter, Receptive Field:_
  Kernels are small matrices used to apply filters across the input.
  The receptive field refers to the area of the input that influences a particular feature map value.
- _Feature Map:_
  Result of applying filters to the input, highlighting specific features such as edges or textures.
- _Tensor, Rank, Dimension, Size:_
  Tensors are multi-dimensional arrays. Rank is the number of dimensions,
  size refers to the total number of elements, and dimensions specify the shape.
- _Fully Connected Layer (Dense Layer):_ 
  Every neuron in one layer connects to every neuron in the next,
  crucial for decision-making based on extracted features.

== Implementation
We do not implement a complex ANN from scratch. Instead we use _TensorFlow_.
This is an open source platform for machine learning, which is developed and maintained by Google.
We do not use TF directly, instead we use _Keras_, which provides a higher-level Python API that
hides the complexity of TF.

=== A fully connected ANN with 1 hidden layer
Layers extract representations from the data fed into them.
```py
model = tf.keras.Sequential([
  tf.keras.layers.Flatten(input_shape=(28,28)),
  tf.keras.layers.Dense(128, activation='relu'), # Rectified Linear Unit sets negative value to 0
  tf.keras.layers.Dense(10)
])```
- _First Layer: `tf.keras.layers.Flatten`:_ 
  Transforms images from 2D (28x28 pixels) to 1D (784 pixels),
  unstacks rows of pixels and lines them up. No parameters, only reformats data.
- _Subsequent Layers: `tf.keras.layers.Dense`:_ 
  *First Dense Layer*: Contains 128 fully connected neurons.\
  *Second Dense Layer*: Returns a logits array with a length of 10. Each node indicates the
  score for one of the 10 classes.

==== Compiling
```py
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])```
- _Optimizer:_ This is how the model is updated based on the data it sees and its loss function.
- _Loss function:_ This measures how accurate the model is during training.
  You want to minimize this function to "steer" the model in the right direction.
- _Metrics:_ Used to monitor the training and testing steps.
  The example uses accuracy, the fraction of the images that are correctly classified.

==== Training
```py model.fit(train_images, train_labels, epochs=10)
```
Training the neural network model requires the following steps:
+ _Feed the training data to the model._
  In this example, the training data is in the `train_images` and `train_labels` arrays.
+ _The model learns_ to associate images and labels.
+ You ask the model to _make predictions_ about a test set —
  in this example, the `test_images` array.
+ _Verify_ that the predictions match the labels from the `test_labels` array.

==== Evaluation
```py test_loss, test_acc = model.evaluate(test_images,  test_labels, verbose=2)```\
Compare how the model performs on the test dataset.

==== Make predictions
With the model trained, you can use it to _make predictions_ about some images.
Attach a _softmax layer_ to convert the model's linear outputs (logits) to probabilities,
which should be easier to interpret.

```py
probability_model = tf.keras.Sequential([model, tf.keras.layers.Softmax()]);
predictions = probability_model.predict(test_images)```

== Tensor Terminology
- _Tensor:_ A multi-dimensional array with a uniform data type.
- _Rank:_ The number of dimensions #hinweis[(axes)] in a tensor.
- _Dimension:_ A particular dimension of a tensor, such as rows or columns.
- _Shape:_ The size of each dimension in a tensor.
- _Size:_ The total number of elements in a tensor, product of the shape's elements.
- _Indexing:_ Accessing tensor elements using their indices.
- _Reshaping:_ Changing the shape of a tensor without altering its data.
- _Broadcasting:_ Extending tensors of different shapes for arithmetic operations #hinweis[(scalar product)].


= Convolutional Neural Network (CNN)
A CNN is an ANN with _multiple convolutional layers stacked_
(and usually combined with fully connected layers). It is used to process and classify images.\
To flatten an image into a long vector is not optimal for processing, because
_neighborhood information_ is lost. Instead, we can apply something called _convolution_.\
In theory, a fully connected network could also learn to classify images an outperform a CNN.
The reason is that a _dense network_ has a _lower bias but higher variance_.
The pre-wired structure of the convolution imposes a _bias_ to the mode.
This _helps_ the model to learn _faster_. A model that integrates some domain knowledge into
its pre-wired structure requires less data to be trained. This form of bias is called _inductive bias_.

== Feature Detector 
For example, one part of the brain detects faces, another objects, another shapes and another lines.
Together, these informations form an image.

=== Mathematical Model
- _The Input:_ An image #hinweis[(width #sym.times height (#sym.times 3 if RGB))] and
  a filter #hinweis[(kernel)], which consists of an $m times n$ matrix in the simplest case
  #hinweis[(1 channel, gray scale)] or an $m times n times d$ "stack of matrices" where the
  depth of the kernel is equal to the number of input channels #hinweis[(3 for RGB)].
- _The operation:_ Convolution of the image with the kernel. The kernel "slides" over the image
  and on each slide, a matrix multiplication is performed. This can be done in parallel.
  Multiple kernels are trained to extract different features.
  Multi-channel inputs need at least as many kernels as channels.
- _The output:_ This function returns a _feature map_. This is a "map" #hinweis[(like a gray
  scale image)] that shows the locations where a feature is present. One convolution produces
  one feature map. Even if the input and the filter have multiple channels, the output of the
  convolution has one channel.

== Kernels
Kernels #hinweis[(or filters)] are _small matrices_. They slide across the input data and
perform element-wise multiplication. This _produces a feature map_ that _highlights specific
patterns_ or features #hinweis[(like vertical edges)]. The kernel weights are initialized with
random data. In the optimization process, they are adjusted so that the loss is minimized.
The amount by how many pixels is shifted with each slide is called _stride_.
Usually the same in both dimensions, but can be different. Edges, corners and strides that
don't cover the entire input can be dealt with _padding_: _"valid"_ #hinweis[(No padding)] or
_"same"_ #hinweis[(evenly padded with zeroes horizontally & vertically)].

== Feeding Feature Maps into the next Conv-Layer
The output of a convolutional layer looks like a _new image_. We can _apply multiple kernels_
to the same input. This produces _multiple feature maps_ which can be _stacked_ #hinweis[(like
an RGB image is stacked from 3 Channels)].
This output can be fed into the next convolutional layer to _find more complex patterns_.

== Pooling
Instead of directly feeding the next layer, a _pooling layer_ is usually used.
In TF, the default pool size is 2x2. _Max pooling_ only keeps the largest value in the pool.
_Average Pooling_ keeps the average value within the pool. Comes with a loss of information
#hinweis[(loses details, but keeps important features)]. These layers don't have trainable
parameters. _Advantages:_ Reduces the amount of data to process by the pool size
#hinweis[(2x2 pool #sym.arrow 4x less data)],
Field-of-view increases #hinweis[(pooled matrix contains information from a wider input)].

== CNN in Keras
```py
model = Sequential([
  layers.Rescaling(1./255, input_shape=(img_height, img_width, 3)),  # Normalize pixel values 
  layers.Conv2D(16, 3, padding='same', activation='relu'),  # 16 neurons, 3x3 kernel, ReLU
  layers.MaxPooling2D(),  # Max pooling layer to reduce spatial dimensions
  layers.Conv2D(32, 3, padding='same', activation='relu'),  # 32 neurons, 3x3 kernel, ReLU
  layers.MaxPooling2D(),  # Max pooling layer to reduce spatial dimensions
  layers.Conv2D(64, 3, padding='same', activation='relu'),  # 64 neurons, 3x3 kernel, ReLU
  layers.MaxPooling2D(),  # Max pooling layer to reduce spatial dimensions
  layers.Flatten(),  # Flatten the tensor to a 1D vector
  layers.Dense(128, activation='relu'),  # Fully connected layer with 128 neurons, ReLU activation
  layers.Dense(num_classes)  # Output layer with units equal to the number of classes
])```

#pagebreak()

== Calculation Example
#image("img/aiap_4.png", width: 80%)

#wrap-content(
  image("img/aiap_5.png"),
  align: top + right,
  columns: (65%, 35%)
)[
  === Convolve the input image with kernel 1
  Horizontal stride = 1, vertical stride = 2, Padding: none (valid), Pool: 2x2\
  #hinweis[*Stride* by how many pixels the kernel is shifted.]\
  $23 dot 1 + 255 dot 0 + 21 dot 0 + 34 dot 1 = 57$ #hinweis[(Shift kernel 1 to the right)]\
  $255 dot 1 + 40 dot 0 + 34 dot 0 + 200 dot 1 = 455$\
  ... #hinweis[(Shift 2 down when kernel has reached the right edge)]\
  _Size of the resulting feature map:_ $2 times 4$\
  If a kernel has _multiple channels_, the channels need to be calculated separately and
  then added together with the bias to get the final value.\
  *Example:* Channel 1 returns $158$, Channel 2 returns $hyph.minus 14$, Channel 3 $653$.
  Bias is $1$. $=> 158 + hyph.minus 14 + 653 + 1 = underline(798)$
]
#wrap-content(
  image("img/aiap_6.png"),
  align: top + right,
  columns: (80%, 20%)
)[
  === Apply the max pooling operation 
  Using a $2 times 2$ kernel-size, stride = kernel-size (default).
  This means get the _max value_ of every $2 times 2$ square.\
  _Size of the feature map after pooling:_ $1 times 2$
]

#wrap-content(
  image("img/aiap_7.png"),
  align: top + right,
  columns: (80%, 20%)
)[
  === Shape of output of one Conv-Layer
  After all Kernels are applied, what will be the shape of the output of one Conv-Layer with
  these four kernels, followed by max pooling?
  _Output tensor of rank=3 with shape= (1,2,4)_
]
#wrap-content(
  image("img/aiap_8.png"),
  align: top + right,
  columns: (80%, 20%)
)[
  === Observations
  - Applying a threshold _highlights the structure_ of the "image".
    _The different kernels detect different structures_. For example, the "long diagonal"
    #hinweis[(255, 200, 190, 240)] is captured by the first kernel.
    The diagonal 190, 200 is *not* detected by kernel 2 because of the stride of 2.
  - By applying _max pooling_ on these small feature maps, we _lose many details_.
  - Kernel 3 is more specific than kernel 4. _Kernel 3 is a "corner detector"._ 
    All other kernels, which have 0s, strongly respond to the block in the lower left corner.
]

=== Calculation of trainable parameters (degrees of freedom)
```py
model = models.Sequential()
model.add(layers.Conv2D(32, (3, 3), activation='relu', input_shape=(32, 32, 3)))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Conv2D(64, (3, 3), strides=2, padding='same', activation='relu'))
model.add(layers.MaxPooling2D((2, 2)))
model.add(layers.Flatten())
model.add(layers.Dense(10))
```
==== Layer 1, Conv2D
_The number of weights/trainable parameters_ in this layer is calculated as\
$(fxcolor("grün", "kernel size") dot fxcolor("orange", "input channels") +
fxcolor("rot", "bias")) dot fxcolor("gelb", "amount of kernels in this layer") =>
(fxcolor("grün", (3 dot 3)) dot fxcolor("orange", 3) + fxcolor("rot", 1)) dot
fxcolor("gelb", 32) = 896$ \
#hinweis[Note that the number of parameters in a ConvLayer does *not* depend on
the width and height of the input]

_Output shape:_
$(fxcolor("grün", "input_width") - fxcolor("orange", "kernel_width")) /
fxcolor("rot", "stride") + 1 => 
(fxcolor("grün", 32) - fxcolor("orange", 3)) / fxcolor("rot", 1) + 1 = 30$ \
Without padding, we can apply the kernel $30$ times over a width of 32px
#hinweis[(same for height)]. Each of the $32$ kernels outputs one $30 times 30$ feature map.
Therefore, the output has the shape $underline(30 times 30 times 32)$. \
#hinweis[Default values are `strides=(1,1), padding="valid"`]

==== Layer 2, MaxPooling
MaxPooling Layers do not have weights and therefore no trainable parameters.\
_Output shape:_ $(fxcolor("grün", "input_width") - fxcolor("orange", "pool_width")) /
fxcolor("rot", "stride") + 1 =>
(fxcolor("grün", 30) - fxcolor("orange", 2)) / fxcolor("rot", 2) + 1 = underline(15)$,
shape is therefore $underline(15 times 15 times 32)$\
#hinweis[Default values are `strides=None, padding="valid"`.
When `strides=None`, it will default to `pool_size`.]

==== Layer 3, Conv2D
Number of _trainable parameters:_ 
$(fxcolor("grün", (3 dot 3)) dot fxcolor("orange", 32) + fxcolor("rot", 1)) dot
fxcolor("gelb", 64) = underline(18'496)$

_Output shape:_ Note the `padding='same'` hyper-parameter. This adds rows and columns of 0s to
the input, evenly to the left/right or up/down when `'same'` so that the output feature map
will have the _same_ dimensions as the input tensor.\
*Calculation:*
The input size is _increased by 1_ at the left and at the right:
#fxcolor("hellblau", $(+(2 dot 1)$)\
$(fxcolor("grün", 15) + #fxcolor("hellblau", $(+(2 dot 1)$) - fxcolor("orange", 3)) \/
fxcolor("rot", 2) - 1 = underline(8)$.
So the resulting shape is $underline(8 times 8 times 64)$

==== Layer 4, MaxPooling
No trainable parameters.\
_Output shape:_ $(fxcolor("grün", 8) - fxcolor("orange", 2)) \/ fxcolor("rot", 2) + 1
= underline(4)$,
Shape is $underline(4 times 4 times 64)$\

==== Layer 5, Flatten
Does not have any trainable parameters.\
_Output shape:_ Flatten takes the $4 times 4 times 64$ input tensor and reshapes it into a
"flat" $1024 times 1$ vector.

==== Layer 6, Dense
_Trainable weights:_ Each of the $10$ neurons is fully connected, plus $1$ bias: 
$10 dot (1024 + 1) = underline(10'250)$ \
_Output shape:_ $10 times 1$ or simply $10$.

==== Hoy many trainable parameters does the network have?
$896 + 18'496 + 10'250 = underline(29'642)$ trainable Parameters.

==== What would happen if the input image is 2-times wider?
The number of trainable parameters in the ConvLayers does not change, but the output feature
maps are larger. The Dense Layer would have $approx 2 times$ more parameters.


= Deep learning architectures
A network is typically called a _deep neural network_ if it has at least 2 hidden layers.\ 
*AlexNet:* competed in the ImageNet Large Scale Visual Recognition Challenge in 2012 and
_massively outperformed_ its competition. The original paper's primary result was that
_using Dropout_ in the fully-connected layers was _very effective_. Even though the model was
_computationally expensive_, it was made feasible due to the utilization of GPUs during training.
#image("img/aiap_11.png")

#pagebreak()

== Softmax Function
Softmax _turns logits_ (numeric output of the last layer) _into probabilities_ by normalizing
each number so the entire output vector adds up to one. A softmax layer is often appended to
the last layer of a CNN. Softmax is _differentiable_ because we need gradient descent to train
the model.

$ S(y)_i = exp(y_i)/(sum_(j=1)^n exp(y_j)) $ 

=== Sparse categorical crossentropy Loss
Sparse Categorical Cross Entropy is a loss function that is commonly used. It is an extension
of the Cross Entropy loss function that is used for binary classification problems.
The sparse categorical cross-entropy is used in cases where the output labels are represented
in a sparse matrix format.

- _Forward Pass (Inference):_ Input passes through the network, the network produces logits
  which are converted to probabilities. The true label is provided and the loss is calculated.
- _Backward Pass (Learning):_ Using gradient descent, the network updates its weights in
  reverse order. The gradients of the loss with respect to each weight are computed.
  The weights are adjusted to minimize the loss.

This _iterative process_ improves the _model's accuracy_ over time.

== Dropout Layer
A dropout layer is a regularization method used to _prevent overfitting_.
In the dropout layer, a random subset of the current neurons is dropped.
```py tf.keras.layers.Dropout(0.1)```\
The data is often better interpretable _with_ dropout layers in between because it _reduces
noise_ and allows rapid testing of different "versions" of a model where some neurons are
missing. This forces the network to break up situations where neurons have adapted to mistakes
from previous layers and thus makes the model _more robust_ and _increases its generalization_.


= Autoencoder
#wrap-content(
  image("img/aiap_9.png"),
  align: top + right,
  columns: (65%, 35%)
)[
  An Autoencoder is an unsupervised artificial neural network that learns how to efficiently
  compress and encode data, then learns how to reconstruct the data back _from_ the reduced
  encoded representation _to_ a representation that is as close to the original input as
  possible. In other words, it _reproduces input_. It uses mean squared error as its loss
  function #hinweis[(distance between the RGB values of the input & output pixel, sum up all
  squared distances and divide by number of pixels)].
]

It consists of 4 main parts:
- _Encoder:_ The model learns how to reduce the input and compress the data into an encoded representation.
- _Bottleneck:_ The layer that contains the compressed representation of the input data, the _latent space_
- _Decoder:_ The model learns how to reconstruct the data from the encoded representation.
- _Reconstruction Loss:_ Method that measures how well the decoder is performing.

== Applications
- _Compression:_ Encoding can group pixels together and therefore be used for compression.
- _Denoising:_ The bottleneck layer learns useful features which are shared across different
  images. Isolated/Random pixels (noise) are not representable in the code. Therefore the
  reconstruction is a composition of the most relevant features, a "denoised" image.

== Deconvolution
The _opposite_ process from _Convolution_. It is also known as Transposed Convolution.
In Deconvolution, the _feature map gets converted into an Image_.

== Mel-Spectrogram
We can also classify audio with an image classifier by transforming the audio into a mel-scaled
spectrogram which shows the _power of different frequencies over the time_.
This transformation can be done with Fourier transform.

/*
== Basic Autoencoder
=== Compression
```py
class Autoencoder(Model): 
  def __init__(self, latent_dim, shape):
    super(Autoencoder, self).__init__()
    self.latent_dim = latent_dim # dimensionality of bottleneck
    self.shape = shape # shape of input, like 28x28px
    self.encoder = tf.keras.Sequential([
      layers.Flatten(), # matrix to vector, is then fed into the next layer
      layers.Dense(latent_dim, activation='relu'),
    ]) # encoder part
    self.decoder = tf.keras.Sequential([
      layers.Dense(tf.math.reduce_prod(shape).numpy(), activation='sigmoid'),
      layers.Reshape(shape) # inverse of flatten
    ]) # decoder part

  def call(self, x): # this is the function that gets executed
    encoded = self.encoder(x)
    decoded = self.decoder(encoded)
    return decoded

shape = x_test.shape[1:]
latent_dim = 64 # the bigger this number, the more details can be represented.
# Compression Factor: go down from 28x28 = 784 to 64 -> ~factor 12
autoencoder = Autoencoder(latent_dim, shape)

autoencoder.compile(optimizer='adam', loss=losses.MeanSquaredError())
autoencoder.fit(x_train, x_train, epochs=10, shuffle=True, validation_data=(x_test, x_test))
encoded_imgs = autoencoder.encoder(x_test).numpy() # apply encoder
decoded_imgs = autoencoder.decoder(encoded_imgs).numpy() # apply decoder

```
=== Denoising
```py
class Denoise(Model):
  def __init__(self):
    super(Denoise, self).__init__()
    self.encoder = tf.keras.Sequential([
      layers.Input(shape=(28, 28, 1)), # 1 grayscale channel, images of 28x28px
      layers.Conv2D(16, (3, 3), activation='relu', padding='same', strides=2), # 16 3x3 kernels
      layers.Conv2D(8, (3, 3), activation='relu', padding='same', strides=2)]) #8 3x3 kernels
      # dimensionality of bottleneck (Output of encoder): 7x7x8
      # (Input 28x28, after first layer because of stride=2: 14x14x16, output of second layer because stride=2: 7x7x8
    self.decoder = tf.keras.Sequential([
      layers.Conv2DTranspose(8, kernel_size=3, strides=2, activation='relu', padding='same'),
      layers.Conv2DTranspose(16, kernel_size=3, strides=2, activation='relu', padding='same'),
      layers.Conv2D(1, kernel_size=(3, 3), activation='sigmoid', padding='same')])

  def call(self, x):
    encoded = self.encoder(x)
    decoded = self.decoder(encoded)
    return decoded

autoencoder = Denoise()
```
*/

#pagebreak()

= Representations
== Expression Trees
#image("img/aiap_10.png", width: 80%)
There is not always just one solution, there might be different trees for the same expression.

== Backpropagation
Backpropagation is a supervised learning technique to _adjust the weights of the neurons to
minimize the error_. It calculates the gradient of the loss function with respect to each
weight in the network. This gradient is then used to update the weights in the opposite
direction of the gradient, which in turn minimizes the loss function.

The algorithm works by computing the error between the predicted output and the actual output
for each example and then _propagating_ this error back through the network to adjust the weights.
This is repeated multiple times until the weights converge to a point where the error is minimized.

*Steps of the algorithm:* 
#columns(2)[
  + _Initialize the weights_ of the network _randomly_
  + _Forward propagate an input_ through the network to get the predicted output.
  + _Compute the error_
  #colbreak()
  4. _Backward propagate the error_ through the network to compute the gradient
  + _Update the weights_ in the opposite direction of the gradient using SGD or something similar
  + _Repeat_ steps 2-5 for multiple iterations
]

== Gradient Descent
MSE loss function for a quadratic model and a single data point $x,y$:\
$L("values the function depends on") = ("loss function" - "datapoint i")^2 
=> L(x,y; a,b) = (\ax^2 + \bx + c - y)^2$


= Advances Techniques in Keras
== Data Augmentation
The _convolution_ is _translation-invariant_
#hinweis[(Object still identifiable if shifted along x or y axis)] but not
_rotation-invariant_ #hinweis[(CNN fails to classify a rotated image)].
It is also in general not _scale-invariant_ #hinweis[(a scaled object does not get recognized)].

A classifier can only classify data that is _similar to the training data_. If we have not
enough training data, we need to artificially create more by applying different transformations
#hinweis[(De-texturized, de-colorized, edge enhanced, salient edge map, flip, rotate, ...)]. 

```py layers.Resizing(IMG_SIZE, IMG_SIZE), layers.Rescaling(1./255),
layers.RandomFlip("horizontal_and_vertical"), layers.RandomRotation(0.2),
skimage.color.rgb2gray(imgs)
```

== Batch Normalization
Batch normalization applies a transformation that maintains the _mean output close to 0 and the
standard deviation close to 1_. _Advantages:_ We can train deeper networks and increase the
learning rate. This is added as a layer inside the model.\
```py keras.layers.BatchNormalization( ... )```

== Learning Rate Scheduling
A constant learning rate is often not optimal. It is often necessary to try different learning
rates and schedulers. _Annealing_ is one example of Learning Rate Scheduling.\
With a scheduler, we can have _faster training_ #hinweis[(higher learning rate in the beginning)]
and _better convergence into a (local) minimum_.
```py keras.optimizers.schedules.CosineDecay( ... )```

== Accuracy vs. Loss
*Accuracy:*
_Counting the correct samples._ All samples contribute the same amount to this value,
they are either correct or incorrect. This _cannot be optimized_ with a function.\
*Loss:*
The loss is a _differentiable_ function which _can be optimized_.
Very confidently wrong predictions make the loss explode.

== U-Net Architecture
Is a "classic" architecture for image segmentation that splits the image into fore- and background.
#image("img/aiap_12.png", width: 78%)

=== Complex Network Topologies
*Skip Connections:* Keep a pointer to the output of a layer.
Pass that data unchanged to a deeper layer in the network.
```py
skip1 = layers.Conv2D(1, kernel_size=1, activation=None, padding='same', strides=1)(x)
... # potentially many more layers here
x = layers.concatenate([x, skip1])```

*Multiple Outputs:* An ANN can have multiple output layers.
Each output layer can have its own Loss Function.


= Reinforcment Learning (RL)
*Behavioral Learning:* Learning is the _change in behavior_ that occurs as a _result of experience_.\
In RL, an _agent interacts with its environment_. The agent _selects from available actions_.
The agent's goal is to select those actions which maximize the (long term) reward.
In the beginning, the agent selects _random actions_. Over time, the agent _learns_ to _prefer_
those actions that yield _higher_ (long term) _rewards_: _trial and error_.\
RL does _not learn from "pre-collected" labelled / unlabeled data_.
It learns from _interaction_ with the environment.\
*Fields of Application:*
Healthcare, Education, Transportation, Energy, Business Management, Science, NLP,
Computer vision, robotics, games, computer systems, finance, ....\
*Limitations:*
_Sample efficiency_ #hinweis[(No real progress in the first couple million trials)],
_Difficult_ to define the _reward function_.

== Basic Concepts
An RL agent tries to solve an RL-problem by learning the actions that maximize reward.\
- _Environment:_ The Environment the agent is in. Contains states and actions.
- _Agent:_ Knows its state #hinweis[(but not the entire environment, only "sensor data")],
  observes the states, takes actions and learns optimal behavior to maximize reward
  #hinweis[(hedonistic behavior)].
- _State:_ The agent arrives in a new state after taking a action #hinweis[(`S0`, `S1`, `S2` etc.)].
- _Terminal State:_ A state where there aren't any further actions that can be taken by the
  agent #hinweis[(Terminates an episode)].
- _Episode:_ One "run" of the agent through the environment until it lands in a terminal state.
- _Actions:_ The agent takes an action to get from one state to another #hinweis[(`a0`, `a1`)].
- _Rewards:_ The agent gets a positive or negative reward when it arrives in a new state.
  Through this, the agent learns what "good" and "bad" actions are.
- _Policy $bold(pi)$:_ Fully defines the behavior of the agent. Maps states to action-selection
  probabilities. Normally an agent starts with a random policy and then tries to improve it.
  #hinweis[("At state S53, go left with probability 76% and right with 24%" is noted as
  $pi(s=53, a="left") = 0.76$)]

== Markov Decision Process (MDP)
Composed of 4 entities:
_S_ #hinweis[(set of states {`S0`, `S1`, ... `S7`})],
_A_ #hinweis[(set of actions {`a0`, `a1`})],
_R_ #hinweis[(positive or negative rewards)] an
_P_ #hinweis[(Transitions, visualized with arrows)].
MDPs are a very general mathematical function. They are used to describe and study a large
variety of problems.

#wrap-content(
  image("img/aiap_13.png"),
  align: top + right,
  columns: (65%, 35%)
)[
  == General RL framework
  An agent _decides_ which _action_ to take _according to its policy $bold(pi)$_.
  The action has an _effect on the environment_. As a result, the environment _transitions to
  the next state_ and _returns a reward_. This _loop_ continues _infinitely_ or until a 
  _terminal state_ is reached. 
]
=== Goal of an RL
"Find the optimal policy $pi^*$" by trial-and-error. $pi^*$ is: At each state $S_t$, take the
action $A_t$ which returns the _largest sum of (discounted) rewards_.

=== Different policies, different sum of rewards <rl-map>
#hinweis[Without discounting]
#grid(columns: (1fr, 1fr, 2fr), gutter: 1em, [
  *Optimal policy $bold(pi^*)$*
  #table(
    columns: (1fr, 1fr, 1fr),
    [State], [`a0`], [`a1`],
    [_`S0`_], [1], [0],
    [_`S1`_], [0], [1],
    [_`S2`_], [1], [0],
    [_`S3`_], [-], [-],
    [_`S4`_], [0.5], [0.5],
    [_`S5`_], [-], [-],
    [_`S6`_], [-], [-],
    [_`S7`_], [-], [-]
  )
],[
  *Random policy $bold(pi^"random")$*
  #table(
    columns: (1fr, 1fr, 1fr),
    [State], [`a0`], [`a1`],
    [_`S0`_], [0.5], [0.5],
    [_`S1`_], [0.5], [0.5],
    [_`S2`_], [0.5], [0.5],
    [_`S3`_], [-], [-],
    [_`S4`_], [0.5], [0.5],
    [_`S5`_], [-], [-],
    [_`S6`_], [-], [-],
    [_`S7`_], [-], [-]
  )
], [
  #image("img/aiap_14.png") 
])

#grid(columns: (1fr, 2fr), gutter: 1em, [
*Assume the agent starts in state `x` and follows  $bold(pi^*)$. Total reward?* 
  #table(
    columns: (auto, 1fr),
    [State], [Total Reward], 
    [_`S0`_], [$V^pi^*("S0") = hyph.minus 1 + 4 + 5 = 8$],
    [_`S1`_], [$V^pi^*("S1") = 4 + 5 = 9$],
    [_`S2`_], [$V^pi^*("S2") = 7$],
    [_`S3`_], [$V^pi^*("S3") = 0$], 
  )
],[
  *Same for Random Policy. What does the agent collect on average? Work backwards.* 
  #table(
    columns: (auto, 1fr),
    [State], [Total Reward],
    [_`S7`_], [$V^pi^*("S7") = 0$],
    [_`S4`_], [$V^pi^*("S4") = pi("S4", "a0") dot 5 + pi("S4", "a1") dot 5  = 0.5 dot 5 + 0.5 dot 5= 5$],
    [_`S1`_], [$V^pi^*("S1") = 0.5 dot hyph.minus 10 + 0.5 dot (4+5) = hyph.minus 5 + 4.5 =  hyph.minus 0.5$],
    [_`S0`_], [$V^pi^*("S0") = 0.5 dot (hyph.minus 1 + hyph.minus 0.5) + 0.5 dot (5 + 0) = 1.75$]
  )
])

This is the function used for this table: 
$V("S0") = pi("S0", "a0") dot (R + V("S1")) + pi("S0", "a1") dot (R + V("S1"))$\
$R$: Reward of $A$, $V(S_1)$: V-State of the state the action leads to.
If this is a terminal state, this is zero.

=== Discounting
A _far away reward is less attractive_. In a discrete-time RL, it is common to apply a
_constant discount factor $bold(gamma)$_ at each time-step to steer the agent away from far
away rewards towards nearer ones with the same or a similar reward. The value of $gamma$
depends on the problem, but typical values are 0.95, 0.98, 0.99, 0.999.
Discounting is a simple and efficient strategy to lump together all kinds of risks.

#image("img/aiap_15.png", width: 80%)
Discounting is only applied on _future rewards_. In each state, the agent receives the actual
reward $r$. When in state $S_t$, a reward 3 steps into the future is discounted by the power of
2: $y^2R_(t+3)$. But when actually moving there, the agent receives $r_(t+3)$, not $y^2R_(t+3)$. 

#pagebreak()

*Exercise*\ 
While in state `S0`, evaluate the discounted reward of the two paths
in the image in @rl-map for $fxcolor("grün", gamma = 0.95)$.\
$tau_1$: `S0-S1-S4-S7` $= hyph.minus 1 dot fxcolor("grün", (0.95)^0)
+ 4 dot fxcolor("grün", (0.95)^1) + 5 dot fxcolor("grün", (0.95)^2) = 7.3$ \
$tau_2$: `S0-S2-S6` $= 0 dot fxcolor("grün", (0.95)^0) + 7 dot fxcolor("grün", (0.95)^1)
= 6.65$\
The trajectory $tau_1$ has a _higher discounted reward_ and gets therefore chosen.

*Reward $bold(R)$* is the _quantity an agent receives immediately_ when landing in a state.
Usually described with $r_t$ \ 
#hinweis[($r_t$ is used for the actual value that has been received by the agent,
$R_t$ is used for the random variable before observing the actual outcome)]\
*Return $bold(G)$:* is the _discounted sum of future rewards_. Is a sum of random variables and
therefore a random variable itself. Usually the symbol $G_t$ is used.\

#block(
  $ G_t eq.def R_(t+1) + gamma R_(t+2) + gamma^2 R_(t+3) + ... = sum_(k=0)^infinity gamma^k R_(t+k+1) $
)

=== State-action value $bold(Q(s,a))$
The state-action value $Q^pi (s,a)$ is defined as the expected Return $G$, when starting in
state $s$, taking action $a$, and following the policy $pi$ thereafter.
#block(
  $ q_pi (s,a) eq.def EE_pi [#fxcolor("grün", $G_t$) | S_t = s, A_t = a] = 
  #fxcolor("orange", $EE_pi$) [sum_(k=0)^infinity gamma^k R_(t+k+1) #fxcolor("rot", "|") S_t =s, A_t = a] $
)
#hinweis[#tcolor("grün", "expected Return G"),
#tcolor("orange", "Expected return when following policy " + $pi$),
#tcolor("rot", "Reward we get when we are in this state")]

The goal of many RL algorithms is to estimate these $q$-values. $Q$-values are expectations and
depend on the policy and on $gamma$. To calculate a Q-value, you only need the next state/action values.
A simple method to approximate expectations is _sampling:_ simulate many trajectories,
observe the rewards and calculate the mean reward. _The sample mean is an approximation of the expectation._
This is called _Monte-Carlo_ Method.

== Temporal Difference Learning
In state $s_t$, taking action $a_t$, the agent expects the future reward $q(s_t, a_t)$.
After taking a step, the agent observes the next state and reward:
$q(s_t, a_t) eq.quest r_(t+1) + gamma q(s_(t+1), a_(t+1))$ #hinweis[($q(s_t, a_t)$ is the
expected future reward before taking a step, $r$ is an actual observation and $q(s_(t+1),
a_(t+1))$ is the expected return from here on)]\
This equation _does not hold_.
We need to add a _difference $bold(delta_t)$_ to make both sides equal: 

$q(s_t, a_t) fxcolor("rot", + delta_t) eq.quest r_(t+1) + gamma q(s_(t+1), a_(t+1))$

$delta$ is needed because of the difference between the expected value and the actual value.
#hinweis[(i.e. the average expected value of a dice roll is 3.5, but the actual value can never be 3.5)] 
We can now start with any random initial guess for the $q$-values and then use the
_temporal difference error / reward prediction error (RPE) $bold(delta_t)$_ to _improve_ our guess.
Over time, the $q$-values will _converge_ towards the "true" expected values and $delta = 0$
#hinweis[(on average)]. Positive RPE means we got more than predicted.

*The TD-Learning update rule:*\ 
$"RPE" = r_(t+1) + gamma q(s_(t+1), a_(t+1)) - q(s_t, a_t)$\
$ q(s_t, a_t) arrow.l q(s_t, a_t) + alpha dot "RPE"$ #hinweis[(updated guess overwrites the old guess)]\
_$bold(alpha)$_ is the _learning rate_ or _step size_ #hinweis[(typically between 0.000001 and 0.1)]. 

=== State-Action-Reward-State-Action (SARSA)
Unlike Monte-Carlo, SARSA integrates _new information_ at _every step_, not just at the end of
an episode. The agent in state $S$ chooses action $A$, lands in state $S'$ and gets reward $R$.
It then chooses its next action $A'$ based on its policy $Q$. The initial guess $Q(S, A)$ gets
updated based on the agents observation of $S$, $A$, $R$, $S'$ and its choice of $A'$.
The RPE calculates the difference between the predicted $Q(S, A)$ and the actual value $Q(S', A')$.\ 
$fxcolor("grün", Q(S,A)) arrow.l fxcolor("grün", Q(S,A))  + fxcolor("orange", alpha)
[fxcolor("hellgrün", R) + fxcolor("rot", gamma) fxcolor("dunkelblau" , Q(S', A'))
- fxcolor("grün", Q(S,A))]$\ 
$arrow.l.r.double "Immediate reward" + "discounted" ["prediction in" S', A'
- Q"-value of prediction when we started"]$

#let salsatable = table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [], [`S1`], [`S2`], [`S3`],
  [_`a1`_], [$1.1$], [$hyph.minus 0.9$], [$1.3$],
  [_`a2`_], [$0$], [$1.1$], [$1.2$],
  [_`a3`_], [$fxcolor("grün", 2.1)$], [$1.5$], [$fxcolor("dunkelblau" , hyph.minus 1.4)$],
)

#grid(columns: (7fr, 2fr), gutter: 1em, [
  Assume $fxcolor("orange", alpha = 0.1)$ and $fxcolor("rot", gamma = 0.9)$.
  An agent performs the following state-action sequence:\
  `S1 - a3 - S3 - a3`.
  *Which entry of the Q-Table gets updated?*
  The $fxcolor("grün", 2.1)$\
  *When landing in `S3`, it receives a $fxcolor("hellgrün", bold(+4))$ reward.
  Calculate the updated $Q$-value with SARSA:*\
  $"RPE" = fxcolor("hellgrün", 4) + fxcolor("rot", 0.9)
  dot (fxcolor("dunkelblau" , hyph.minus 1.4)) - fxcolor("grün", 2.1) = underline(0.64)$\
  $fxcolor("grün", 2.1) arrow.l fxcolor("grün", 2.1) + fxcolor("orange", 0.1) dot 0.64 
  = underline(2.164)$  
],[#salsatable])

*Q-Learning:*
A variant of SARSA. The update of $Q(s,a)$ is based on the agent's observation of $r$ and $s'$,
and _the $Q$-value of "best" action in $S'$_: 
$fxcolor("grün", Q(S,A)) arrow.l fxcolor("grün", Q(S,A))  + fxcolor("orange", alpha)
[fxcolor("hellgrün", R) + fxcolor("rot", gamma) max_a Q(S', a) - fxcolor("grün", Q(S,A))]$ 

The next action $a'$ can differ from the best action. That means, in the next step, the agent
can take one action $a'$, but use another action $max_a$ for the Q-Update.
Algorithms that learn from actions that differ from the actual taken action are called
_off-policy_. SARSA = on-policy #hinweis[(takes this action in the next step)],
Q-learning = off-policy #hinweis[(next step decided by Q-learner based on best Q-value.)]

=== SARSA and Q-learning Calculations
An agent has interacted with the Treasure-Map environment and approximated the
following Q-Table #hinweis[(state $times$ action)]:

#wrap-content(
  image("img/aiap_19.png"),
  align: top + right,
  columns: (89%, 11%)
)[
  *SARSA:*\
  $"RPE"_t = r_(t+1) + gamma Q^pi (s_(t+1), a_(t+1)) - Q^pi (s_t, a_t), space.quad
  Q^pi (s_t, a_t) arrow.l Q^pi (s,a) + alpha "RPE"_t $ \
  *Q-learning:* \
  $"RPE"_t = r_(t+1) + gamma max_(tilde(a)) Q^pi (s_(t+1), tilde(a)) - Q^pi (s_t, a_t), space.quad 
  Q^pi (s_t, a_t) arrow.l Q^pi (s,a) + alpha "RPE"_t $ \
  *When moving form `S0` to `S2`, the RPE is always 0 because when landing in stat `S2` the reward is 0:*\
  This is wrong because the RPE depends not only on the immediate reward.\
  *The agent is in state `S0` and follows the trajectory $tau =$ `S0 - a0 - S1 - a0 - S3`.
  Assume $bold(#fxcolor("hellgrün", $gamma = 0.95$))$ and
  $bold(#fxcolor("dunkelblau", $alpha = 0.05$))$* 
]

*Calculate the RPE and the updated $bold(#fxcolor("grün", $Q("s0","a0")$))$:*\
$#fxcolor("grün", $Q("s0","a0")$) = #fxcolor("grün", $4$), space.quad #fxcolor("gelb", $r = -1$)$ 
#hinweis[(see image in @rl-map)]\
$#fxcolor("orange", $Q("s1","a0")$) = #fxcolor("orange", $hyph.minus 8.5$)
arrow.double #fxcolor("hellgrün", $gamma$) #fxcolor("orange", $Q("s1","a0")$)
= #fxcolor("hellgrün", $0.95$) dot #fxcolor("orange", $hyph.minus 8.5$)
= hyph.minus 8.075 arrow.double #fxcolor("gelb", $r$)
+ #fxcolor("hellgrün", $gamma$) #fxcolor("orange", $Q("s1","a0")$)
= #fxcolor("gelb", $hyph.minus 1$) + hyph.minus 8.075 
= hyph.minus 9.075$ \
*RPE SARSA:* 
$#fxcolor("gelb", $r$) + #fxcolor("hellgrün", $gamma$) #fxcolor("orange", $Q("s1","a0")$)
- #fxcolor("grün", $Q("s0","a0")$)
= #fxcolor("gelb", $hyph.minus 1$) + hyph.minus 8.075 - #fxcolor("grün", $4$) 
= hyph.minus 13.075$ \
*$bold(#fxcolor("grün", $Q("s0","a0")$))$ after SARSA update:*
$#fxcolor("grün", $Q("s0","a0")$) + #fxcolor("dunkelblau", $alpha$) ("RPE") 
= #fxcolor("grün", $4$) + #fxcolor("dunkelblau", $0.05$) dot hyph.minus 13.075
= underline(3.34625)$\

$#fxcolor("rot", $max_tilde(a) Q("s1", "a")$) 
= #fxcolor("rot", $6.5$) arrow.double #fxcolor("hellgrün", $gamma$)
  #fxcolor("rot", $max_tilde(a) Q("s1", tilde(a))$)
= #fxcolor("hellgrün", $0.95$) dot #fxcolor("rot", $6.5$) = 6.175\
arrow.double #fxcolor("gelb", $r$) + #fxcolor("hellgrün", $gamma$)
  #fxcolor("rot", $max_tilde(a) Q("s1", tilde(a))$) 
= #fxcolor("gelb", $hyph.minus 1$) + 6.175 = 5.175$\
*RPE Q:* 
$#fxcolor("gelb", $r$) + #fxcolor("hellgrün", $gamma$) #fxcolor("rot", $max_tilde(a)
  Q("s1", tilde(a))$) - #fxcolor("grün", $Q("s0","a0")$) 
= #fxcolor("gelb", $hyph.minus 1$) + 6.175 - #fxcolor("grün", $4$) = 1.175$\
*$bold(#fxcolor("grün", $Q("s0","a0")$))$ after Q-Value update:*
  $#fxcolor("grün", $Q("s0","a0")$) + #fxcolor("dunkelblau", $alpha$) ("RPE") 
= #fxcolor("grün", $4$) + #fxcolor("dunkelblau", $0.05$)  dot 1.175 
= underline(4.05875)$\

=== Epsilon-Greedy-Policy
In order to discover the best available options, an agent needs to _explore_ the _entire_ 
state-action-space. In contrast, in order to _maximize the return_, the agent wants to follow
the _best trajectory_. Therefore, we need a way to describe a _flexible behavior_. \
If the agent just follows the _most promising path_ based on its learned knowledge,
he _stops exploring_ and _starts exploiting_, thus always taking the "best" known action:
a _greedy policy_. This way he might _miss the best trajectory_.
We need to _balance_ between exploration and exploitation with the epsilon-greedy-policy:\
`at each state:
  with probability 1-`#math.epsilon`: Take the action that has the highest value (greedy exploit)
  with probability` #math.epsilon`: Take a random action (explore)` \
_Finding a good value for #math.epsilon is key. Possible strategies:_
fixed at for example $0.1$ or starting at $0.95$ #hinweis[(high exploration)] and reducing/
_annealing_ it over time to $0.05$ #hinweis[(greedy). $epsilon = 1$ means random behavior.]


= Deep Reinforcement Learning
*Disadvantages of Q-tables:* The Q-Table maps $(s,a)$ #hinweis[(state-action pairs)] to
$Q(s,a)$ #hinweis[(expected reward of (s,a))]. Since it is a table, it does _not scale well_.
It is _limited to discrete states and discrete actions_. There is also _lack of
generalization_, there is no relation to neighboring states and actions.
In real life, nearby/similar states often have similar Q-Values and it is reasonable to apply
similar actions. While the input is often _high-dimensional_, the relevant features are often
not #hinweis[(background vs. relevant part of an image)]. A tabular-RL would classify each
changed pixel as a completely independent state #hinweis[(senseless!)]. \
Since $Q$ is a function, we can _approximate_ it. In DRL, the $Q$-values are approximated using
a Deep Neural Network.
_Input:_ the state $s$ #hinweis[(e.g. RGB image, state of a chess board)],
_Output:_ one neuron per action $a$. The neurons activity is $approx Q(s,a)$.

== Deep Q-Network (DQN)
*Replay buffer:*
The transitions that an agent performs during an episode are stored in the replay buffer as a _experience_.
Randomly pick a few experiences, do a forward- and backward-pass to _train_ the
network on this _batch_ of samples.\
*Target Network:*
This is a network that is updated _more slowly_ compared to the Q-Network, which is used to
define the optimal policy based on the value estimation. The target network is _not_ updated
every iteration but once in a while to _stabilize_ the learning process.\
*Epsilon-greedy Policy:* 
Given $Q$-values, which actions should be taken? Epsilon-greedy is simple to implement and
often works well enough for a DQN.
If two actions are _almost equally good_, it is better to use Softmax.

#pagebreak(weak: true)

*Softmax:* 
T or $tau$ is the _temperature_. It gives us control over the _exploration/exploitation_ balance.
_High $bold(tau)$:_ all actions have almost the same probability
#hinweis[(Even with big differences between the Q-Values, they have a similar probability)].
_Low $bold(tau)$:_ for $tau arrow 0$, the policy becomes greedy.
Often, $tau$ is annealed #hinweis[(becomes more greedy over time)].


= Sequential and Time Series Data
*Sequential Data:* 
Words, sentences, streams of text, etc.\
*Time-Series data:* 
Is a _subset_ of sequential data where the x-axis is time
#hinweis[(Stock option pricing, Sensor Data, etc.)].\
Sequential Data is everywhere. It is a tremendous source of information.
It is also a _indispensable tool in science_ and there are a lot of _business opportunities_
and _applications_ #hinweis[(Predictive maintenance, portfolio management, sales, politics,
weather prediction, forecasting traffic, text generation, anomaly detection, ...)]. \
*Model-based Prediction:* 
Based on physics and historical data, _mathematical models_ are developed.
The sequential data provide the initial conditions. Then the models are used to calculate the
evolution. The _quality_ depends on many factors #hinweis[(quality of measurements, quality of
the model, nature of the dynamic system)]. For most time-series, we _do not have a causal
model_. Therefore, predictions need to be made _based on historical data_.
This is done by looking for _structure/patterns_ #hinweis[(Seasonality, Trends)].\
*Feature Engineeering:* 
Assuming some function and optimize the free parameters.\
*Learning from Data:* 
Make very few assumptions about the structure (low bias), machine learning algorithms
_discover_ structure from the data. This can _outperform_ model-based predictions, for example
in the weather forecast.


= Recurrent Neural Network (RNN)
== Models
_One-to-one_ #hinweis[(Sequence has only one time step (static).
One input is fed and one output is generated. This is the case in traditional ANNs.)],\
_Many-to-one_ #hinweis[(sentiment classification - positive/negative sentence)], 
_One-to-Many_ #hinweis[(Image Captioning)],
_Many-to-many_ #hinweis[(Machine Translation)]\
_ANN_ and _FFNN_ #hinweis[(Feed Forward Neural Networks)] are no good match for sequential data
because they are _unable_ to _capture the temporal order_ of a time series, since they treat
each input _independently_ #hinweis[(results aren't based on past data)].
Ignoring the temporal order restrains performance. _CNN_ is partially good for this task, you
can use _filters_ and flatten the input features to 1 dimension (time).
If the forecast depends on _detecting specific patterns_, then _CNNs are a good fit_.
However, convolutions and pooling operations _lose information about the local order of words_.
The meaning could be misinterpreted or the grammar could be incorrect if sequential information is not used.

== RNN Concept
RNNs introduce a _recurrent connection_ which allows information to flow from one time-step to
the next. This allows the RNNs to _maintain internal memory_ and utilize information from the
previous step for the current step and therefore _learn temporal dependencies_. \

== Architecture
#image("img/aiap_16.png", width: 89%)
#hinweis[Note, this is the same cell, but unfolded through time.]\
*Input:* 
$x_t$, could be a one-hot vector corresponding to a word.\
*Hidden state:* 
$h_t$ represents a hidden state at a time $t$ and acts as "memory" of the network.
It is calculated based on the current input and the previous time step's hidden state:
$h_t = f(x_t, h_(t-1))$. $f$ is parameterized by _weights and bias_ which need to be _learned_.
These are _shared_ across all timestamps.\
*Weights:*
The inputs $x_t$ and $h_t$ are multiplied with their weights $W^T_(h x)$ and $W^T_(h h)$ respectively.\
*Bias:*
With an addition, $b_h$ is added to the output of $h_t$ and $x_t$ after their respective weights have been added.\
*Activation function:*
The biased value is put through $g$, a nonlinear activation function
$h_t = g(W^T_(h h) h_(t-1) + W^T_(h x)x_t + b_h)$\
*Output:* The model returns $hat(y)$, the prediction for this timestep.
This value is fed into the network again under the name $h_t$. 

== Training
*Backpropagation:* 
Initialize weights, and repeat until convergence: Forward pass, calculate loss,
calculate gradient, update weights in backward pass.\
*Backpropagation through time (BPTT):*  
The error is propagated backward through time until the initial timestep.\
*Loss Function:* 
_Binary cross entropy_ for binary classification, _categorical cross entropy_ for
multi-class classification. For regression, use _RMSE_.\
*Keras:* ```py model = Sequential() # 3 timesteps, 1 feature, 32 neurons```\ 
```py model.add(SimpleRNN(units=32, input_shape=(3,1), activation = "tanh"))```

== Limitations
*Exploding Gradient:* 
As the backpropagation algorithm advances backwards, the gradient can get _larger and larger_
#hinweis[(huge weight changes)] and therefore _never converges_ on the optimum.
_Gradient Clipping_ and _proper weight initialization_ can help.\
*Vanishing Gradient:* 
As the algorithm advances backwards, the gradient can get _smaller and smaller_ and approach
zero, therefore _never converges_ on the optimum. It is harder and harder to propagate errors
from the loss back to distant past. As a result, it might just learn _short term dependencies_.
Fix with _batch normalization_, _Long short-term memory_, _weight initialization_.


= Transformers and the attention mechanism
Transformers are the _most important deep learning architecture_ for sequence modeling.
They make use of a powerful building block: _the attention mechanism_.\
*Limitations of (simple) RNNs:*
All information about past patterns in the sequence must be conveyed through the hidden signal
$h$ #hinweis[(context vector)]. The longer the sequence, the more information is "faded out".
$h$ is a _bottleneck_.\
*Techniques to overcome these limitations:* 
_Long Short-Term Memory (LSTM)_ has an additional "conveyor belt" signal $c$.
During training, the LSTM learns when to keep / use / modify this signal.
This makes an LSTM a _trainable memory unit_. LSTM still fail to learn from very long sequences.\
We can't feed an _entire sequence_ into a fully connected network: 
Variable length, input is treated _independently_, _exploding_ no. of parameters.
We need to give this "clueless" network a clue: _Inductive Bias_ aka _attention_.

== Attention
Attention assigns varying _levels of importance_ to different words in a sentence,
by calculating "soft" weights #hinweis[(its embedding)], within a specific section of the
entence called the _context window_ to determine its _importance_.
Attention "looks" at all words #hinweis[(all tokens)] in the input sequence.
Each attention head has its own weights $W_q$, $W_k$, $W_v$.
Therefore, different heads look for different patterns, but all heads look at all words. 

== Preprocessing
*Tokenization:*
Long text strings are broken down into _short chunks_ #hinweis[(1 token = 1 word or a part of a word)].
The _output_ is a _sequence of integers_.\
*Embedding:*
The word (or token) indices are then _mapped_ onto a _vector_ with a _position encoding_.
In Keras, this is implemented using a special type of layer: `keras.layers.Embedding`\
*Positional Encoding:* 
For text processing, the _relative position_ of each word _within the sequence is relevant_
#hinweis[(sentence structure)]. For each word, a _"location vector"_ is calculated and added
(or concatenated) to its embedding vector before it is fed into the encoder.
A common technique is based on _trigonometric functions_ sine and cosine using _different frequencies_.

== The two components of Transformers
*Encoders:* 
A stack of _Encoders_ maps the input onto _embedding vectors_. Encoders can process the entire
input sequence in parallel. The sequence of input vectors is passed through a _self-attention
layer_. For each vector in the input, it produces a _weighted_ linear combination of all input
vectors. The same (fully connected) _feed forward network_ is then applied to each vector.
This layer performs a nonlinear transformation. The output is fed into the next encoded layer.

*Decoders:*
A stack of _Decoders_ map the embeddings to the _desired target sequence_.
The Output generation is (usually) word-by-word. Each decoder consists of a _self-attention
layer_, an _encoder-decoder attention layer_ which combines the vectors from the decoder below,
with the embeddings from the encoder, and a _feed forward network_. 

== Calculation of Attention
The _attention head_ consists of the matrices _query $Q$_, _key $K$_ and _value $V$_.
The goal of _attention_ is to look-up the _value $V$_ of those "neighbors" which are strongly
influencing the current token #hinweis[(words with similar meanings)].
An _attention-score_ is calculated between each pair of the embedding vectors.
The attention mechanism is a "softmax-version" of a dictionary:
The _attention score_ is a _similarity measure_ between a _key $K$_ and a _query $Q$_.
Both are vectors, the dot-product is used to calculate how strongly they match.
_Strong match_: #hinweis[(cosine similarity close to 1)] "most" of the value $V$ is returned 
#hinweis[($V *$ cosine similarity)]. _No strong match:_ a close to 0 vector is returned.
_The result of this softmax-lookup is the sum of all values, weighted according to the key/value similarity._
#image("img/aiap_18.png", width: 80%)

More compact representation: $"Attention"(Q,K,V) = "softmax"((Q K^T) / sqrt(d_k)) V$
#hinweis[(The $sqrt(d_k)$ stabilizes the calculation)]


= Transfer learning, foundation models
*Transfer Learning:* 
Train a complex model on Task A, then freeze part of the model and _reuse it for a new/related task B_.
Useful when you have only a few labels / data for your actual task or if you just don't want to
do all of the training by yourself.\
*Foundation Model:*
A large model trained on a vast quantity of data at scale, resulting in a model that can be
_adapted_ to a _wide range of downstream tasks_.\
*In-Context Learning:*
The LM performs a task just by _conditioning on input-output examples_, without optimizing any parameters.
It has _no training phase_, the examples provided in the augmented prompt are _directly
influencing_ the generative process.


= Machine Learning Operations (ML-OPS)
*Components of real-world AI projects:*
Data, Versioning, CI/CD, Monitoring, Reproducibility, Time/Budget constraints, ...\
*CI / CD / CD:*
Continuous integration, Continuous delivery, Continuous Deployment.\
*Training pipeline:*
_Data Collection_ #hinweis[(Provided by customer, generated using models or collected from company experts)],
_Data Preparation_ #hinweis[(augmentation, sampling)],
_Model (Re-)Training_ #hinweis[(infrastructure, consistent versioning, optimization)],
_Model Evaluation_ #hinweis[(acceptance testing, performance evaluation, reproducibility)],
_Model Deployment_ #hinweis[(manage rollout of different networks, track and document)],
_Model Monitoring_ #hinweis[(monitor performance, identify problematic cases, collect feedback and re-train)].\
*Data Engineer:*
Understands _general workflows_ and data flows with all specific requirements.\
*DevOps:*
Has a _technical skill set_: Operate and maintain processing resources, network infrastructure.\
*Data Analyst, ML Engineer:*
Has _in-depth knowledge_ of underlying _algorithm_ and processes.

== Problems with Data
_Biased data_ #hinweis[(unrepresentative of all data)],
too many _similar/redundant samples_ #hinweis[(car with a road)],
_missing edge cases_ #hinweis[(pedestrian coming out of nowhere)],
_bad quality_ #hinweis[(pictures during a rainy day)]\
This can lead to _bad models_. To improve we need to _collect more data_ in _"missing areas"_
or _balance/remove redundant data_.
The last step can be achieved via  _self-supervised learning_ where similar/redundant pictures are
automatically categorized as less relevant. This can decrease dataset size and costs.\
When the training data is _modified_, it should also be _versioned_ to measure performance
across different iterations and to create _reproducible models_. Can be done via Git.
