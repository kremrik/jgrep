import json


proc makeJson*(jsonStr: string): JsonNode =
    try:
        let parsedObj = parseJson(jsonStr)
        return parsedObj
    except JsonParsingError:
        raise
