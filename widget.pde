abstract class Widget
{
  private int posX, posY;
  private String label;
  private color widgetColor, borderColor, labelColor;
  private PFont widgetFont;
  
  Widget(int x, int y, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont)
  {
    this.posX = x;
    this.posY = y;
    this.label = label;
    this.widgetColor = widgetColor;
    this.borderColor = borderColor;
    this.labelColor = labelColor;
    this.widgetFont = widgetFont;
  }
  public int getX()
  {
    return posX;
  }
  public void setX(int x)
  {
    posX = x;
  }
  public int getY()
  {
    return posY;
  }
  public void setY(int y)
  {
    posY = y;
  }
  public void setWidgetColor(color widgetColor)
  {
    this.widgetColor = widgetColor;
  }
  public color getWidgetColor()
  {
    return widgetColor;
  }
  public color getLabelColor()
  {
    return labelColor;
  }
  public void setlabelColor(color labelColor)
  {
    this.labelColor = labelColor;
  }
  public color getBorderColor()
  {
    return borderColor;
  }
  public void setBorderColor(color borderColor)
  {
    this.borderColor = borderColor;
  }
  public String getLabel()
  {
    return this.label;
  }
  public void setLabel(String label)
  {
    this.label = label;
  }
  public PFont getWidgetFont()
  {
    return this.widgetFont;
  }
  public void setWidgetFont(PFont widgetFont)
  {
    this.widgetFont = widgetFont;
  }
  
  void draw() {}
}
