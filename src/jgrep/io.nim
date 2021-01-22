proc readStdin*(): string = 
    let inpt = readLine(stdin)
    return inpt


proc writeStdout*(output: string) =
    stdout.writeLine(output)
