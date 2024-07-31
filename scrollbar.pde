class Scrollbar extends Widget
{
  private int width, height;
  private boolean isHeld;
  private int value;
  private int initialX, initialY;
  private int sliderHeight;
  private double fraction;
  private color sliderColor;
  
  Scrollbar(int x, int y, int width, int height, color widgetColor, color sliderColor, PFont widgetFont, double fraction)
  {
    super(x, y, "", widgetColor, BLACK, BLACK, widgetFont);
    this.width = width;
    this.height = height;
    this.initialX = x;
    this.initialY = y;
    this.isHeld = false;
    this.fraction = fraction;
    this.sliderColor = sliderColor;
    this.sliderHeight =  (int)(height * this.fraction);
  }
  public void draw()
  {
    stroke(this.getBorderColor());
    fill(this.getWidgetColor());
    rect(this.getInitialX(), this.getInitialY(), this.getWidth(), this.getHeight());
    
    fill(this.getSliderColor());
    rect(this.getX(), this.getY(), this.getWidth(), this.getSliderHeight());
  }
  public int getWidth()
  {
    return this.width;
  }
  public void setWidth(int width)
  {
    this.width = width;
  }
  public int getHeight()
  {
    return this.height;
  }
  public void setHeight(int height)
  {
    this.height = height;
  }
  public boolean getIsHeld()
  {
    return this.isHeld;
  }
  public void setIsHeld(boolean isHeld)
  {
    this.isHeld = isHeld;
  }
  public int getValue()
  {
    return this.value;
  }
  public void setValue(int value)
  {
    this.value = value;
  }
  public int getInitialX()
  {
    return this.initialX;
  }
  public void setIntialX(int x)
  {
    this.initialX = x;
  }
  public int getInitialY()
  {
    return this.initialY;
  }
  public void setInitialY(int y)
  {
    this.initialY = y;
  }
  public int getSliderHeight()
  {
    return this.sliderHeight;
  }
  public void setSliderHeight(int sliderHeight)
  {
    this.sliderHeight = sliderHeight;
  }
  public double getFraction()
  {
    return this.fraction;
  }
  public color getSliderColor()
  {
    return this.sliderColor;
  }
  public void setSliderColor(color sliderColor)
  {
    this.sliderColor = sliderColor;
  }
  
  public void toggleClick()
  {
    this.setIsHeld(!(this.getIsHeld()));
  }
  public void getClicked(int mX, int mY)
  {
    if(mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getSliderHeight())
    {
      toggleClick();
    }
  }
  public void toggleRelease()
  {
   if(this.getIsHeld())
   {
      toggleClick();
   }
  }
  public void getDragged(int mY, int pY, int mX)
  {
    if(this.getIsHeld())
    {
      int change = mY - pY;
      if(this.getY() + change > this.getInitialY() + this.getHeight() - this.getSliderHeight())
      {
        this.setY(this.getInitialY() + this.getHeight() - this.getSliderHeight());
      }
      else if(this.getY() + change < this.getInitialY())
      {
        this.setY(this.getInitialY());
      }
      else
      {
        this.setY(this.getY() + change);
      }
      int pos = this.getY() - this.getInitialY();
      this.setValue(pos);
    }
  }
}
