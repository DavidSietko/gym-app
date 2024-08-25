class Button extends Widget
{
  private int width, height;
  private Runnable onClick;
  private boolean clicked;
  private int textSize;
  
  Button(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Runnable onClick)
  {
    super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
    this.width = width;
    this.height = height;
    this.onClick = onClick;
    this.clicked = false;
    this.textSize = 12;
  }
  
  public int getHeight()
  {
    return this.height;
  }
  public void setHeight(int height)
  {
    this.height = height;
  }
  public int getWidth()
  {
    return this.width;
  }
  public void setWidth(int width)
  {
    this.width = width;
  }
  public Runnable getOnClick()
  {
    return this.onClick;
  }
  public void setOnClick(Runnable onClick)
  {
    this.onClick = onClick;
  }
  public boolean getClicked()
  {
    return this.clicked;
  }
  public void setClicked(boolean clicked)
  {
    this.clicked = clicked;
  }
  public int getTextSize()
  {
    return this.textSize;
  }
  public void setTextSize(int textSize)
  {
    this.textSize = textSize;
  }
  public void toggleClick()
  {
    this.setClicked(!this.getClicked());
  }
  
   public void isClicked(int mX, int mY)
  {
    if(mX > this.getX() && mX < this.getX() + width && mY > this.getY() && mY < this.getY() + height)
    {
       toggleClick();
       onClick.run();
    }
  }
  public boolean isHovering(int mX, int mY)
  {
    if(mX > this.getX() && mX < this.getX() + width && mY > this.getY() && mY < this.getY() + height)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  public void draw()
  {
    fill(this.getWidgetColor());
    if(this.getClicked())
    {
      stroke(WHITE);
    }
    else
    {
      stroke(this.getBorderColor());
    }
    rect(this.getX(), this.getY(), this.width, this.height);
    fill(this.getLabelColor());
    textAlign(CENTER, CENTER);
    textFont(this.getWidgetFont());
    textSize(textSize);
    text(this.getLabel(), this.getX() + this.width / 2, this.getY() + this.height / 2);
  }
    void changeColor(color newColor)
  {
    this.setWidgetColor(newColor);
  }
  public JSONObject toJSON()
  {
    JSONObject json = new JSONObject();
    json.setString("label", this.getLabel());
    return json;
  }
  public String fromJSON(JSONObject json)
  {
   return json.getString("label");
  }
}
