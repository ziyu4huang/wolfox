type Thing = object
    _:Union[
    {r,g,b,a :uint8},
    {rgba    :uint32},
    ]

proc main()=
    echo "hello"


main()
