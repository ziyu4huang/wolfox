#include <geos/geom/GeometryFactory.h>
#include <geos/geom/Coordinate.h>
#include <geos/geom/CoordinateArraySequence.h>
#include <geos/geom/LinearRing.h>
#include <geos/geom/Polygon.h>
#include <geos/operation/buffer/BufferOp.h>
#include <iostream>

using namespace geos::geom;
using namespace geos::operation::buffer;

int main() {
    // Initialize GEOS GeometryFactory
    GeometryFactory::Ptr factory = GeometryFactory::create();

    // Create a rectilinear polygon (a square in this example)
    CoordinateArraySequence coords;
    coords.add(Coordinate(0, 0));
    coords.add(Coordinate(10, 0));
    coords.add(Coordinate(10, 10));
    coords.add(Coordinate(0, 10));
    coords.add(Coordinate(0, 0));  // Close the ring

    LinearRing::Ptr shell = factory->createLinearRing(coords);
    Polygon::Ptr polygon = factory->createPolygon(shell, nullptr);

    // Enlarge the polygon by a distance of 2 units
    double distance = 2.0;
    Geometry::Ptr enlargedPolygon = polygon->buffer(distance);

    // Output WKT representation of the original and enlarged polygons
    std::cout << "Original Polygon: " << polygon->toString() << std::endl;
    std::cout << "Enlarged Polygon: " << enlargedPolygon->toString() << std::endl;

    return 0;
}

