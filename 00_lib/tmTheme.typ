// DONE:
// item("markup.bold", None, Some(synt::FontStyle::BOLD)),
// item("markup.italic", None, Some(synt::FontStyle::ITALIC)),
// item("markup.underline", None, Some(synt::FontStyle::UNDERLINE)),
// item("markup.raw", Some("#6b6b6f"), None),
// item("comment", Some("#74747c"), None),
// item("constant.character.escape", Some("#1d6c76"), None),
// item("keyword.operator.math, punctuation.math.typst", Some("#1d6c76"), None),
// item("entity.name.label, markup.other.reference", Some("#1d6c76"), None),
// item("support.macro", Some("#16718d"), None),
// item("keyword, constant.language, variable.language", Some("#d73948"), None),
// item("markup.deleted, meta.diff.header.from-file", Some("#d73948"), None),
// item("storage.type, storage.modifier", Some("#d73948"), None),
// item("constant", Some("#b60157"), None),
// item("punctuation.definition.list", Some("#8b41b1"), None),
// item("meta.diff.range", Some("#8b41b1"), None),
// item("entity.other, meta.interpolation", Some("#8b41b1"), None),
// item("meta.mapping.value.json string.quoted.double.json", Some("#198810"), None),
// item("punctuation.definition.math", Some("#198810"), None),
// item("string", Some("#198810"), None),
// item("markup.inserted, meta.diff.header.to-file", Some("#198810"), None),
// item("entity.name, variable.function, support", Some("#4b69c6"), None),
// item("meta.mapping.key.json string.quoted.double.json", Some("#4b69c6"), None),


// TODO:
// item("meta.annotation", Some("#301414"), None),
// item("string.other.math.typst", None, None),
// item("markup.heading, entity.name.section", None, Some(synt::FontStyle::BOLD)),
// item(
//     "markup.heading.typst",
//     None,
//     Some(synt::FontStyle::BOLD | synt::FontStyle::UNDERLINE),
// ),
// item("markup.list.term", None, Some(synt::FontStyle::BOLD)),

#let tm-theme = ```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>author</key>
  <string>Jasmin</string>
  <key>colorSpaceName</key>
  <string>sRGB</string>
  <key>settings</key>
  <array>
    <dict>
      <key>name</key>
      <string>Comments</string>
      <key>scope</key>
      <string>comment, punctuation.definition.comment</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>italic</string>
        <key>foreground</key>
        <string>{{comment}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Variable</string>
      <key>scope</key>
      <string>variable</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Other</string>
      <key>scope</key>
      <string>meta.diff.range, entity.other, meta.interpolation</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Keyword</string>
      <key>scope</key>
      <string>keyword, keyword.operator</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Storage</string>
      <key>scope</key>
      <string>storage.type, storage.modifier</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Operator, Misc</string>
      <key>scope</key>
      <string>constant.other.color, meta.tag, punctuation.separator.inheritance.php, punctuation.section.embedded, keyword.other.substitution</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Tag</string>
      <key>scope</key>
      <string>entity.name.tag, meta.tag.sgml</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Git Gutter Deleted</string>
      <key>scope</key>
      <string>markup.deleted.git_gutter</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>#ef6b73</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Function, Special Method, Block Level</string>
      <key>scope</key>
      <string>entity.name, entity.name.class, entity.other.inherited-class, variable.function, support.function, keyword.other.special-method, meta.block-level, support</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{blue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Other Variable, String Link</string>
      <key>scope</key>
      <string>support.other.variable, string.other.link</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>#ef6b73</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Constant</string>
      <key>scope</key>
      <string>constant</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{orange}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Number, Constant, Function Argument, Tag Attribute, Embedded</string>
      <key>scope</key>
      <string>constant.numeric, constant.language, constant.character, keyword.other.unit</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Number, Constant, Function Argument, Tag Attribute, Embedded</string>
      <key>scope</key>
      <string>support.constant, meta.jsx.js, punctuation.section, string.unquoted.label</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>String, Symbols, Inherited Class, Markup Heading</string>
      <key>scope</key>
      <string>string, keyword.other.template, constant.other.symbol, constant.other.key, entity.other.inherited-class, markup.heading, markup.inserted.git_gutter, meta.group.braces.curly</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>normal</string>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Class, Support</string>
      <key>scope</key>
      <string>entity.name.type.class, support.type, support.class, support.orther.namespace.use.php, meta.use.php, support.other.namespace.php, markup.changed.git_gutter</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Sub-methods</string>
      <key>scope</key>
      <string>entity.name.module.js, variable.import.parameter.js, variable.other.class.js</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Language methods</string>
      <key>scope</key>
      <string>variable.language</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>italic</string>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Html punctuations tags</string>
      <key>scope</key>
      <string>punctuation.definition.tag.end, punctuation.definition.tag.begin, punctuation.definition.tag, meta.group.braces.curly.js, meta.property-value, meta.jsx.js</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Attributes</string>
      <key>scope</key>
      <string>entity.other.attribute-name, meta.attribute-with-value.style, constant.other.color.rgb-value, meta.at-rule.media, support.constant.mathematical-symbols,
      punctuation.separator.key-value</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Inserted</string>
      <key>scope</key>
      <string>markup.inserted, meta.diff.header.to-file</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Deleted</string>
      <key>scope</key>
      <string>markup.deleted, meta.diff.header.from-file</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Changed</string>
      <key>scope</key>
      <string>markup.changed</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Regular Expressions and Escape Characters</string>
      <key>scope</key>
      <string>string.regexp, constant.character.escape</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{darkblue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Math</string>
      <key>scope</key>
      <string>keyword.operator.math, punctuation.math.typst</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{darkblue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>References</string>
      <key>scope</key>
      <string>entity.name.label, markup.other.reference</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{darkblue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Macros</string>
      <key>scope</key>
      <string>support.macro</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{darkblue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Math punctuation ig</string>
      <key>scope</key>
      <string>punctuation.definition.math</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>JSON Value</string>
      <key>scope</key>
      <string>meta.mapping.value.json string.quoted.double.json</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>JSON Key</string>
      <key>scope</key>
      <string>meta.mapping.key.json string.quoted.double.json</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{blue}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>URL</string>
      <key>scope</key>
      <string>*url*, *link*, *uri*</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>underline</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Search Results Lines</string>
      <key>scope</key>
      <string>entity.name.filename.find-in-files</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>ES7 Bind Operator</string>
      <key>scope</key>
      <string>constant.other.object.key</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Italic</string>
      <key>scope</key>
      <string>markup.italic</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Bold</string>
      <key>scope</key>
      <string>markup.bold</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>bold</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Underline</string>
      <key>scope</key>
      <string>markup.underline</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>underline</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Strike</string>
      <key>scope</key>
      <string>markup.strike</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>strike</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Quote</string>
      <key>scope</key>
      <string>markup.quote</string>
      <key>settings</key>
      <dict>
        <key>fontStyle</key>
        <string>italic</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Raw</string>
      <key>scope</key>
      <string>markup.raw</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{black}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Raw Block</string>
      <key>scope</key>
      <string>markup.raw.block</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{black}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markup - Table</string>
      <key>scope</key>
      <string>markup.table</string>
      <key>settings</key>
      <dict>
        <key>background</key>
        <string>#1d2433aa</string>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markdown - Plain</string>
      <key>scope</key>
      <string>text.html.markdown, punctuation.definition.list_item.markdown</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markdown - Markup Raw Inline</string>
      <key>scope</key>
      <string>text.html.markdown markup.raw.inline</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markdown - Heading</string>
      <key>scope</key>
      <string>markdown.heading, markup.heading | markup.heading entity.name, markup.heading.markdown punctuation.definition.heading.markdown</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{green}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>Markdown - Raw Block Fenced</string>
      <key>scope</key>
      <string>markup.raw.block.fenced.markdown</string>
      <key>settings</key>
      <dict>
        <key>background</key>
        <string>#d7dce210</string>
        <key>foreground</key>
        <string>{{purple}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>JSON Key - Level 0</string>
      <key>scope</key>
      <string>source.json meta.structure.dictionary.json string.quoted.double.json - meta.structure.dictionary.json meta.structure.dictionary.value.json string.quoted.double.json, source.json meta.structure.dictionary.json punctuation.definition.string - meta.structure.dictionary.json meta.structure.dictionary.value.json punctuation.definition.string</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
    <dict>
      <key>name</key>
      <string>JSON Key - Level 1</string>
      <key>scope</key>
      <string>source.json meta meta.structure.dictionary.json string.quoted.double.json - meta meta.structure.dictionary.json meta.structure.dictionary.value.json string.quoted.double.json, source.json meta meta.structure.dictionary.json punctuation.definition.string - meta meta.structure.dictionary.json meta.structure.dictionary.value.json punctuation.definition.string</string>
      <key>settings</key>
      <dict>
        <key>foreground</key>
        <string>{{red}}</string>
      </dict>
    </dict>
  </array>
  <key>uuid</key>
  <string>0e709986-46a0-40a0-b3bf-c8dfe525c455</string>
</dict>
</plist>```.text
