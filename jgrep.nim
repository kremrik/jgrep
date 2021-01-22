import json
import options
import os


proc readStdin(): string = 
    let inpt = readLine(stdin)
    return inpt


proc writeStdout(output: string) =
    stdout.writeLine(output)


proc getGrepStr(): string =
    let grepStr = paramStr(1)
    return grepStr


proc makeJson(jsonStr: string): JsonNode =
    try:
        let parsedObj = parseJson(jsonStr)
        return parsedObj
    except JsonParsingError:
        raise


proc findValue(jsonObj: JsonNode, value: string): Option[JsonNode] =
    let jKind = jsonObj.kind

    case jKind:
        of JString, JInt, JFloat, JBool, JNull:
            if $jsonObj == value:
                return some(jsonObj)
            else:
                return none(JsonNode)

        of JObject:
            var inner = newJObject()

            for key, val in pairs(jsonObj):
                var res = findValue(val, value)
                if res != none(JsonNode):
                    inner[key] = val
            
            if len(inner) > 0:
                return some(inner)
            else:
                return none(JsonNode)

        of JArray:
            return none(JsonNode)


proc main() =
    let inpt = readStdin()
    let grepStr = getGrepStr()
    let jsonObj = makeJson(inpt)
    let searchVal = findValue(jsonObj, grepStr)
    
    if searchVal == none(JsonNode):
        writeStdout("Value '" & grepStr & "' not found")
    else:
        let output = searchVal.get()
        writeStdout($output)


when isMainModule:
    main()
