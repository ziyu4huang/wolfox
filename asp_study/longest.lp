#script (python)

import clingo
import itertools
import sys

def main(prg):
    matrix = [list(line.split()) for line in sys.stdin]

    def data():
        for i, row in enumerate(matrix):
            for j, cell in enumerate(row):
                if cell == '0':
                    yield f'cell(({i}, {j})).\n'

    def on_model(model):
        step = {}
        for atom in prg.symbolic_atoms:
            if atom.symbol.name == 'step' and model.contains(atom.symbol):
                a, d, b = atom.symbol.arguments
                step[a] = d, b
        moves = []
        a = clingo.Tuple((0, 0))
        while step[a][1] != clingo.Tuple((0, 0)):
            d, a = step[a]
            moves.append(d)
        print(len(moves) + 1)
        print(','.join(f'{d} {len(list(g))}' for d, g in itertools.groupby(moves)))

    prg.add('data', [], ''.join(data()))
    prg.ground([('base', []), ('data', [])])
    prg.solve(on_model=on_model)

#end.

#program base.

dir(s, (1, 0); e, (0, 1); n, (-1, 0); w, (0, -1)).
adj((X, Y), D, (X+DX, Y+DY)) :- cell((X, Y)), dir(D, (DX, DY)), cell((X+DX, Y+DY)).
adj(A, end, (0, 0)) :- cell(A).
{step(A, D, B) : adj(A, D, B)} = 1 :- visit(A).
:- visit(B), {step(A, D, B) : adj(A, D, B)} != 1.
visit((0, 0)).
visit(B) :- step(A, D, B).
:~ visit(A). [-1, A]

#show step/3.