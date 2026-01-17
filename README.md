# Lighthouse QML components: Ace editor

This is a QML module web view wrapper for the Ace code editor (https://ace.c9.io/). It provides a convenient way to integrate the Ace editor into QML-based projects.

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
You can import the `AceEditor` component and use it with `content` and `mode` properties to display and edit code. The editor supports syntax highlighting for many languages.

```qml
import Lighthouse.AceEditor 1.0

AceEditor {
    content: "your code here"
    mode: "javascript"
    
    onEditorContentChanged: function(newContent) {
        // Handle content changes
    }
}
```
