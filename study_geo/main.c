#include <geos_c.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    // Initialize GEOS
    initGEOS(NULL, NULL);

    // Create a rectilinear polygon (a square in this example)
    GEOSCoordSequence* coordSeq = GEOSCoordSeq_create(5, 2);
    GEOSCoordSeq_setX(coordSeq, 0, 0);
    GEOSCoordSeq_setY(coordSeq, 0, 0);
    GEOSCoordSeq_setX(coordSeq, 1, 10);
    GEOSCoordSeq_setY(coordSeq, 1, 0);
    GEOSCoordSeq_setX(coordSeq, 2, 10);
    GEOSCoordSeq_setY(coordSeq, 2, 10);
    GEOSCoordSeq_setX(coordSeq, 3, 0);
    GEOSCoordSeq_setY(coordSeq, 3, 10);
    GEOSCoordSeq_setX(coordSeq, 4, 0);  // Close the ring
    GEOSCoordSeq_setY(coordSeq, 4, 0);  // Close the ring

    GEOSGeometry* shell = GEOSGeom_createLinearRing(coordSeq);
    GEOSGeometry* polygon = GEOSGeom_createPolygon(shell, NULL, 0);

    // Enlarge the polygon by a distance of 2 units
    double distance = 2.0;
    GEOSGeometry* enlargedPolygon = GEOSBuffer(polygon, distance, 30);
	
    // Output WKT representation of the original and enlarged polygons
    char* wktOriginal = GEOSGeom_toWKT(polygon);
    char* wktEnlarged = GEOSGeom_toWKT(enlargedPolygon);
    /*
    printf("Original Polygon: %s\n", wktOriginal);
    printf("Enlarged Polygon: %s\n", wktEnlarged);

    // Clean up
    GEOSFree(wktOriginal);
    GEOSFree(wktEnlarged);
    */

    GEOSGeom_destroy(polygon);
    GEOSGeom_destroy(enlargedPolygon);

    // Finish GEOS
    finishGEOS();

    return 0;
}

