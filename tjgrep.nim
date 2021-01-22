from jgrep import findValueInJson


# let nullJson = ""
# let nullJsonVal = "foo"
# let nullJsonGold = ""
# let nullJsonOutput = findValueInJson(nullJson, nullJsonVal)
# doAssert nullJsonOutput == nullJsonGold


let simpleJson = """{"foo":1}"""
let simpleJsonVal = "1"
let simpleJsonGold = """{"foo":1}"""
let simpleJsonOutput = findValueInJson(simpleJson, simpleJsonVal)
doAssert simpleJsonOutput == simpleJsonGold
