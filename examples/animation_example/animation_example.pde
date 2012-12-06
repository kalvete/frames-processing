/*

    Animation library for Processing.
    Copyright (c) 2012 held jointly by the individual authors.

    This file is part of Animation library for Processing.

    Animation library for Processing is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Animation library for Processing is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Animation library for Processing.  If not, see
    <http://www.gnu.org/licenses/>.

*/
import animation.*;

Animations animations;

Animation hatRight;
Animation hatLeft;
Animation hatInfectedRight;
Animation hatInfectedLeft;
Animation hatDeceasedRight;
Animation hatDeceasedLeft;
Animation currentAnimation;
int px = width / 2;
int py = height / 2;
boolean right = true;
boolean infected = false;
boolean deceased = false;

void setup()
{
  size(16*30, 9*30);
  frameRate(12);
  background(20);
  animations = new Animations(this);

  //
  // example derived from darwin_award, an entry for Ludum Dare 24
  // http://www.youtube.com/watch?v=UDkGt-TpJ34&feature=youtu.be 
  // http://www.ludumdare.com/compo/ludum-dare-24/?action=preview&uid=1864
  //
  // Licensed GPL version 3 or later, copyright updated by the author for inclusion here
  //

  List<PImage> hatFrames = animations.createFrameList("hat.png", 0, 0, 24, 24, 4);
  hatRight = animations.createLoopedAnimation(hatFrames);
  hatLeft = animations.createLoopedAnimation(animations.flipHorizontally(hatFrames));

  List<PImage> hatInfectedFrames = animations.createFrameList("hat-infected.png", 0, 0, 24, 24, 4);
  hatInfectedRight = animations.createLoopedAnimation(hatInfectedFrames);
  hatInfectedLeft = animations.createLoopedAnimation(animations.flipHorizontally(hatInfectedFrames));

  List<PImage> hatDeceasedFrames = animations.createFrameList("hat-deceased.png", 0, 0, 24, 24, 16);
  hatDeceasedRight = animations.createAnimation(hatDeceasedFrames);
  hatDeceasedLeft = animations.createAnimation(hatDeceasedFrames);
}

void draw()
{
  fill(20);
  rect(0, 0, width, height);

  updateAnimation();
  currentAnimation.advance();
  image(currentAnimation.getCurrentFrame(), px, py);
}

void mousePressed()
{
  if (!infected)
  {
    infected = true;
  }
  else if (!deceased)
  {
    deceased = true;
  }
}

void mouseMoved()
{
  if (!deceased)
  {
    if ((mouseX - 12) > px)
    {
      right = true;
    }
    else
    {
      right = false;
    }
    px = mouseX - 12;
    py = mouseY - 24 - 8;
  }
}

void updateAnimation()
{
  if (right)
  {
    if (deceased)
    {
      currentAnimation = hatDeceasedRight;
    }
    else if (infected)
    {
      currentAnimation = hatInfectedRight;
    }
    else
    {
      currentAnimation = hatRight;
    }
  }
  else
  {
    if (deceased)
    {
      currentAnimation = hatDeceasedLeft;
    }
    else if (infected)
    {
      currentAnimation = hatInfectedLeft;
    }
    else
    {
      currentAnimation = hatLeft;
    }
  }
}