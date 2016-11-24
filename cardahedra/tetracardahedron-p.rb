#!/usr/bin/env ruby
require 'MiniLightModelling.rb'




### header ###

$iterations       = 100
$width, $height   = 512, 512
#$eyePosition      = [0, 0.055, -0.19]
#$lookDirection    = [0, 0, 1]
#$eyePosition      = [0, 0.28 * 0.8, -0.12 * 0.8]
#$lookDirection    = [0, -1, 0.5]
$eyePosition      = [0, 0.16 * 1.2, -0.12 * 1.2]
$lookDirection    = [0, -1, 1]
$viewAngle        = 60
#$skyEmission      = [906.4, 942.4, 1151.2]
$skyEmission      = [9758.5, 9882.5, 10359.0]#[8068, 9060, 12872]#
$groundReflection = [0.87, 0.9, 0.87]#[0.75, 0.75, 0.75]#[0.1, 0.09, 0.07]




### materials ###

teststuff = cover([0.7, 0.2, 0.2], [100, 1000, 100])

brass           = cover([0.541, 0.505, 0.394], cBlack)
wallMaterial    = cover([0.87, 0.9, 0.87], cBlack)
floorMaterial   = cover([0.5, 0.5, 0.45], cBlack)
ceilingMaterial = cover(cWhite, cBlack)
woodDark        = cover([0.386, 0.3375, 0.289], cBlack)
aluminium       = cover([0.34, 0.34, 0.34], cBlack)




### tetrahedon ###

cardWidth  = 0.05
cardLength = cardWidth * ((Math.sqrt(5) + 1) / 2)
cardHeight = 0.0005

card = group(
   instance(
      block,
      scale(cardWidth / 2, cardHeight, cardLength),
      translate(-cardWidth / 4, 0, 0),
      rotate(:z, +6),
      woodDark
   ),
   instance(
      block,
      scale(cardWidth / 2, cardHeight, cardLength),
      translate( cardWidth / 4, 0, 0),
      rotate(:z, -6),
      brass
   )
)

# slightly rotated along length axis,
# almost laying flat on top of ground
card0 = instance(
   card,
   translate(0, (cardHeight / 2), -(cardLength / 2))
)

face0 = group(
   instance( card0, rotate(:y, 0 * 360.0/3.0) ),
   instance( card0, rotate(:y, 1 * 360.0/3.0) ),
   instance( card0, rotate(:y, 2 * 360.0/3.0) )
)

face0Part = group(
#   instance( card0, rotate(:y, 0 * 360.0/3.0) ),
   instance( card0, rotate(:y, 1 * 360.0/3.0) ),
   instance( card0, rotate(:y, 2 * 360.0/3.0) )
)

dihedralAngle = Math.acos( 1.0/3.0 ) * (180.0 / Math::PI)
tetraEdge     = (1.5 * cardLength) * 2.0 / Math.sqrt(3)
tetraHeight   = tetraEdge * Math.sqrt(6) / 3.0

face = instance(
   face0,
   translate(0, 0, cardLength),
   rotate(:x, -dihedralAngle),
   translate(0, tetraHeight, 0)
)

facePart = instance(
   face0Part,
   translate(0, 0, cardLength),
   rotate(:x, -dihedralAngle),
   translate(0, tetraHeight, 0)
)



tetrahedron1 = group(
   instance(
      face0Part,
      rotate(:y, 360.0/3.0),
      translate(0, cardHeight, 0)
   )
)

tetrahedron2 = group(
   instance(
      face0,
      translate(0, cardHeight, 0)
   )
)

tetrahedron3 = group(
   instance(
      face0,
      rotate(:z, 180),
      translate(0, cardHeight, 0)
   )
)

tetrahedron4 = group(
   instance(
      face0,
      rotate(:z, 180),
      translate(0, cardHeight, 0)
   ),
   instance( facePart, rotate(:y, 0) ),
   instance( facePart, rotate(:y, 1 * 360.0/3.0) )
)

tetrahedron5 = group(
   instance(
      face0,
      rotate(:z, 180),
      translate(0, cardHeight, 0)
   ),
   instance( facePart, rotate(:y, 0) ),
   instance( facePart, rotate(:y, 1 * 360.0/3.0) ),
   instance( facePart, rotate(:y, 2 * 360.0/3.0) )
)

tetrahedron6 = group(
   instance(
      face0,
      rotate(:z, 180),
      translate(0, cardHeight, 0)
   ),
   instance( face, rotate(:y, 0) ),
   instance( facePart, rotate(:y, 1 * 360.0/3.0) ),
   instance( face, rotate(:y, 2 * 360.0/3.0) )
)

tetrahedron7 = group(
   instance(
      face0,
      rotate(:z, 180),
      translate(0, cardHeight, 0)
   ),
   instance( face, rotate(:y, 0) ),
   instance( face, rotate(:y, 1 * 360.0/3.0) ),
   instance( face, rotate(:y, 2 * 360.0/3.0) )
)



floor = instance( quadrangle, rotate(:x, -90), wallMaterial )



output(
   group(
      floor,
      instance( tetrahedron7,
         translate(0, cardWidth * 0.39, 0),
         rotate(:y, 15) )
   )
)
