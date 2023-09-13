template duckSpeak(arg: untyped) =
  if arg.hasField("speak"):
    arg.speak()
  else:
    echo "Can't speak"

type
  Dog = object
    name: string

  Duck = object
    sound: string

proc speak(d: Duck) =
  echo "The duck says ", d.sound

proc main() =
  let myDog = Dog(name: "Fido")
  let myDuck = Duck(sound: "Quack")

  duckSpeak(myDog)
  duckSpeak(myDuck)

main()

