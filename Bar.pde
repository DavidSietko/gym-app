class Bar
{
  private int x, y;
  private int barWidth, barHeight;
  private color barColor;
  
  Bar(int x, int y, int barWidth, int barHeight, color barColor)
  {
    this.x = x;
    this.y = y;
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.barColor = barColor;
  }
  public int getX()
  {
    return this.x;
  }
  public void setX(int x)
  {
    this.x = x;
  }
  public int getY()
  {
    return this.y;
  }
  public void setY(int y)
  {
    this.y = y;
  }
  public int getWidth()
  {
    return this.barWidth;
  }
  public void setWidth(int barWidth)
  {
    this.barWidth = barWidth;
  }
  public int getHeight()
  {
    return this.barHeight;
  }
  public void setHeight(int barHeight)
  {
    this.barHeight = barHeight;
  }
  public color getBarColor()
  {
    return this.barColor;
  }
  public void setBarColor(int barColor)
  {
    this.barColor = barColor;
  }
  
  public void draw()
  {
    noStroke();
    fill(this.getBarColor());
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
  }
}
