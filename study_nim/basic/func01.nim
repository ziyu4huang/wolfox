

proc getUserCity(firstName, lastName: string): string =
    case firstName
    of "Damien": return "Tokyo"
    of "Alex": return "New York"
    else: return "Unknown"

proc method01(var1: int): string =
    return "hello var1=" & $var1

proc main() =
    let loc = getUserCity("Alex", "xxx")
    echo "Alex live at ", loc
    echo method01(1)

main()

