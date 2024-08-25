class Bar
{
  private int x, y;
  private int barWidth, barHeight;
  private color barColor;
  private String label;
  private color labelColor;
  private int textSize;
  
  Bar(int x, int y, int barWidth, int barHeight, String label, color barColor, color labelColor)
  {
    this.x = x;
    this.y = y;
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.barColor = barColor;
    this.label = label;
    this.labelColor = labelColor;
    this.textSize = 12;
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
  public String getLabel()
  {
    return this.label;
  }
  public void setLabel(String label)
  {
    this.label = label;
  }
  public color getLabelColor()
  {
    return this.labelColor;
  }
  public void setLabelColor(color labelColor)
  {
    this.labelColor = labelColor;
  }
  public int getTextSize()
  {
    return this.textSize;
  }
  public void setTextSize(int textSize)
  {
    this.textSize = textSize;
  }
  
  public void draw()
  {
    noStroke();
    fill(this.getBarColor());
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    
    fill(this.getLabelColor());
    textAlign(CENTER, CENTER);
    textSize(this.getTextSize());
    text(this.getLabel(), this.getX() + this.getWidth() / 2, this.getY() + this.getHeight() / 2);
  }
}
