#script (python)

import clingo

class Context:
    def id(self, x):
        return x

    def seq(self, x, y):
        return [x, y]

def main(prg):
    prg.ground([("base", [])], context=Context())
    prg.solve()

#end.

p(@id(10)).
q(@seq(1,2)).