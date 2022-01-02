#!/usr/bin/env python

import networkx as nx

class input(object):
    def __init__(self, world_string):
        rows = world_string.split("\n")
        column_count = len(rows[0])
        blocked_cells = []
        x = 0
        y = -1
        for row in rows:
            if len(row) > column_count:
                column_count = len(row)
            y += 1
            for column in row:
                if column == '1':
                    blocked_cells.append((y, x))
                x += 1
            x = 0
        self.matrix = world(len(rows), column_count)
        self.block_graph(blocked_cells)
        self.matrix.add_sink()

    def block_graph(self, block_list):
        for cell in block_list:
            self.matrix.block_cell(cell)


class world(object):
    SINK = "END"

    def __init__(self, rows=3, columns=3):
        self.graph = nx.grid_2d_graph(rows, columns)
        for e in self.graph.edges():
            self.graph[e[0]][e[1]]["weight"] = -1.0

    def block_cell(self, node):
        neighbours = list(self.graph[node].keys())
        for linked_node in neighbours:
            self.graph.remove_edge(node, linked_node)

    def add_sink(self):
        matrix = self.graph.nodes()[:]
        self.graph.add_node(world.SINK)
        for source_cell in matrix:
            self.graph.add_edge(source_cell, world.SINK, weight=1.0)


class algorithm(object):
    SOURCE = (0, 0)

    def find_path(graph):
        def _heuristic(current, target):
            if current == target:
                return 0.0
            cost = nx.astar_path(graph, algorithm.SOURCE,
                                 current, lambda x, y: 1)
            return -1 * len(cost)
        path = nx.astar_path(graph, algorithm.SOURCE, world.SINK, _heuristic)
        return path[:-1]


class output(object):
    directions = {
        (1,  0): "n",
        (-1,  0): "s",
        (0,  1): "w",
        (0, -1): "e"
    }

    def edge_to_direction(source_node, dest_node):
        row_delta = source_node[0]-dest_node[0]
        column_delta = source_node[1]-dest_node[1]
        return output.directions[(row_delta, column_delta)]

    def path_to_directions(path):
        result = ""
        for step in range(len(path)-1):
            result += output.edge_to_direction(path[step], path[step+1])
        return result

    def simplify_directions(directions):
        directions += "\0"
        count = 0
        result = ""
        last = ""
        for d in directions:
            if d != last or d == "\0":
                result += "{} {},".format(last, count)
                count = 0
                last = ""
            if count == 0:
                last = d
                count = 1
                continue
            if d == last:
                count += 1
        return result[3:-1]



if __name__=='__main__':
    contents="010\n000\n100"    #read from file?

    data=input(contents).matrix.graph
    result_path=algorithm.find_path(data)
    directions=output.path_to_directions(result_path)
    directions=output.simplify_directions(directions)
    print(directions+"\n")
    print(str(result_path)[1:-1].replace('), (',') --> (').replace(', ',','))
