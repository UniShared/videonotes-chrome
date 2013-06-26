chrome.runtime.onMessage.addListener (request, sender, sendResponse) ->
  chrome.tabs.captureVisibleTab null, {}, (dataUrl) ->
    if request.dimensions
      canvas = document.createElement("canvas")
      context = canvas.getContext("2d")
      dimensions = request.dimensions
      image = new Image()

      canvas.width = dimensions.width
      canvas.height = dimensions.height

      image.onload = ->
        context.drawImage image, dimensions.left, dimensions.top, dimensions.width, dimensions.height, 0, 0, dimensions.width, dimensions.height
        sendResponse canvas.toDataURL()
        return

      image.src = dataUrl
  return true