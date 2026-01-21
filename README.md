# Lighthouse QML components: Ace editor

This is a QML module wrapper for the Ace code editor (https://ace.c9.io/). It provides a convenient way to integrate the Ace editor into QML-based projects.

NOTE: Project is still in development.

## Getting started

Git submodule is used to get the JavaScript sources for Ace editor. Here are the steps:
```
git clone --recursive <repo-url>
cd qml-lighthouse-ace-editor

# Or if you have already repo cloned:
# git submodule update --init --recursive

# One way to include only necessary files:
cd Lighthouse/AceEditor/ace-builds
git sparse-checkout init --no-cone
git sparse-checkout set /LICENSE src-min-noconflict
```

## Usage

```qml
import Lighthouse.AceEditor 1.0

AceEditor {
    content: "your code here"
    mode: "javascript"
    theme: "tomorrow_night"
    defaultBackgroundColor: "#1d1f21"
    
    onEditorContentChanged: function(newContent) {
        // Handle content changes
    }
    
    onEditorReady: {
        // Editor is now fully initialized and ready.
        // Before this, API could be unavailable.
    }
}
```

### Properties

- **`content: string`** - Text content of the editor
- **`mode: string`** - Syntax highlighting mode (e.g., "javascript", "python", "text"). Default: "text"
- **`theme: string`** - Ace editor theme (e.g., "tomorrow_night", "monokai", "github"). Default: ""
- **`defaultBackgroundColor: color`** - Background color for the WebView. Default: "transparent"

### Signals

- **`editorContentChanged(string newContent)`** - Emitted when the editor content changes
- **`editorReady()`** - Emitted when the editor is fully initialized and ready to use

### Functions

- **`setContent(string content)`** - Set the editor content
- **`getContent(function callback)`** - Get the editor content
- **`setMode(string mode)`** - Set the syntax highlighting mode
- **`setTheme(string theme)`** - Set the Ace editor theme
- **`setEditorOption(string optionName, var value)`** - Set an Ace editor option
- **`getEditorOption(string optionName)`** - Get an Ace editor option
- **`setRendererOption(string optionName, var value)`** - Set an Ace renderer option
- **`getRendererOption(string optionName)`** - Get an Ace renderer option
- **`callEditorFunction(string functionName, ...args)`** - Call any Ace editor function

### Example: Setting Editor Options

```qml
AceEditor {
    id: editor
    
    onEditorReady: {
        editor.setEditorOption("fontSize", 14)
        editor.setEditorOption("wrap", true)
        editor.setRendererOption("showPrintMargin", false)
    }
}
```
