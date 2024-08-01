class Checkbox extends Widget
{
  private int length;
  private boolean isChecked;
  
  Checkbox(int x, int y, int length, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont)
  {
    super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
    this.length = length;
    this.isChecked = false;
    this.setLabel("");
  }
  public int getLength()
  {
    return this.length;
  }
  public void setLength(int length)
  {
    this.length = length;
  }
  public boolean getIsChecked()
  {
    return this.isChecked;
  }
  public void setIsChecked(boolean isChecked)
  {
    this.isChecked = isChecked;
  }
  
  public void toggleChecked(int mX, int mY)
  {
    if(mX > this.getX() && mX < this.getX() + this.length && mY > this.getY() && mY < this.getY() + this.length)
    {
      this.setIsChecked(!(this.getIsChecked()));
    }
  }
  public void draw()
  {
    if(this.getIsChecked() == true)
    {
    fill(GREEN);
    }
    else
    {
      fill(this.getWidgetColor());
    }
    stroke(this.getBorderColor());
    rect(this.getX(), this.getY(), length, length);
  }
}
