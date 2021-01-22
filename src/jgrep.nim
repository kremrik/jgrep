from ./jgrep/cli import getGrepStr
from ./jgrep/serde import makeJson
from ./jgrep/io import readStdin, writeStdout

import json
import options


proc maybefindValueInJson(jsonObj: JsonNode, value: string): Option[JsonNode] =
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
                var res = maybefindValueInJson(val, value)
                if res != none(JsonNode):
                    inner[key] = val
            
            if len(inner) > 0:
                return some(inner)
            else:
                return none(JsonNode)

        of JArray:
            return none(JsonNode)


proc findValueInJson*(jsonData: string, findValueInJson: string): string =
    let jsonObj = makeJson(jsonData)
    let searchVal = maybefindValueInJson(jsonObj, findValueInJson)

    if searchVal == none(JsonNode):
        return "Value '" & findValueInJson & "' not found"
    else:
        let output = searchVal.get()
        return $output


proc main() =
    let inpt = readStdin()
    let grepStr = getGrepStr()
    writeStdout(findValueInJson(inpt, grepStr))


when isMainModule:
    main()
