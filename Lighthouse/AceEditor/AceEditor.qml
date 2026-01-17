import QtQuick
import QtQuick.Controls
import QtWebEngine
import QtWebChannel

Item {
    id: root

    property string content: ""
    property string mode: "text"
    property alias editor: webView

    signal editorContentChanged(string newContent)

    WebChannel {
        id: channel
        registeredObjects: [bridge]
    }

    QtObject {
        id: bridge
        WebChannel.id: "bridge"

        function contentChanged(content) {
            root.editorContentChanged(content)
        }
    }

    WebEngineView {
        id: webView
        anchors.fill: parent
        backgroundColor: "#1d1f21"

        webChannel: channel

        url: Qt.resolvedUrl("ace-editor.html")

        onLoadingChanged: function(loadRequest) {
            if (loadRequest.status === WebEngineView.LoadSucceededStatus) {
                Qt.callLater(function() {
                    webView.runJavaScript(`
                        (function() {
                            if (typeof window.setAceContent === 'function') {
                                window.setAceContent(${JSON.stringify(root.content)}, ${JSON.stringify(root.mode)});
                            } else if (window.editor && typeof window.editor.setValue === 'function') {
                                window.editor.setValue(${JSON.stringify(root.content)});
                                window.editor.clearSelection();
                                window.editor.session.setMode("ace/mode/${root.mode}");
                            }
                        })();
                    `)
                })
            }
        }

        function setContent(content) {
            if (webView.loading === WebEngineView.LoadSucceededStatus) {
                webView.runJavaScript(`
                    (function() {
                        if (window.editor) {
                            window.editor.setValue(${JSON.stringify(content)});
                            window.editor.clearSelection();
                        }
                    })();
                `)
            }
        }

        function getContent(callback) {
            webView.runJavaScript(`
                (function() {
                    return window.editor ? window.editor.getValue() : "";
                })();
            `, function(result) {
                if (callback) {
                    callback(result)
                }
            })
        }

        function setMode(mode) {
            if (webView.loading === WebEngineView.LoadSucceededStatus) {
                webView.runJavaScript(`
                    (function() {
                        if (window.editor) {
                            window.editor.session.setMode("ace/mode/${mode}");
                        }
                    })();
                `)
            }
        }
    }

    onContentChanged: {
        if (webView.loading === WebEngineView.LoadSucceededStatus) {
            webView.setContent(root.content)
        }
    }

    onModeChanged: {
        if (webView.loading === WebEngineView.LoadSucceededStatus) {
            webView.setMode(root.mode)
        }
    }
}
