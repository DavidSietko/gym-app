class Textbox extends Widget
{
  private int width, height;
  private String text, label;
  private boolean isEditable;
  private int textLength = 10;
  private int textSize;
  
  Textbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont)
  {
    super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
    this.width = width;
    this.height = height;
    this.text = "";
    this.isEditable = false;
    this.textSize = 12;
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
  public String getText()
  {
    return this.text;
  }
  public void setText(String text)
  {
    this.text = text;
  }
  public boolean getIsEditable()
  {
    return this.isEditable;
  }
  public void setIsEditable(boolean isEditable)
  {
    this.isEditable = isEditable;
  }
  public int getTextSize()
  {
    return this.textSize;
  }
  public void setTextSize(int textSize)
  {
    this.textSize = textSize;
  }
  public int getTextLength()
  {
    return this.textLength;
  }
  public void setTextLength(int textLength)
  {
    this.textLength = textLength;
  }
  
  public void isClicked(int mX, int mY)
  {
    if(mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() && mY < this.getY() + this.getHeight())
    {
      this.setIsEditable(!this.getIsEditable());
    }
  }
  public void stopEditing()
  {
    if(key == ENTER && this.getIsEditable() == true)
    {
      this.setIsEditable(false);
    }
  }
  public void editText()
  {
    if(this.getIsEditable())
    {
      if(key != CODED)
      {
        if(key == BACKSPACE && this.text.length() > 0)
        {
          this.text = this.getText().substring(0, this.getText().length() - 1);
        }
        else if( key != BACKSPACE && key != ENTER && key != TAB)
        {
          this.text = this.getText() + key;
        }
      }
    }
  }
  public void keepInBox()
  {
    if(this.getText().length() > this.getTextLength())
    {
      this.text = this.getText().substring(0, this.getTextLength() - 1);;
    }
  }
  public void draw()
  {
    stroke(this.getBorderColor());
    if(this.getIsEditable())
    {
      stroke(BLUE);
    }
    fill(this.getWidgetColor());
    rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    
    fill(this.getLabelColor());
    textFont(this.getWidgetFont());
    textSize(textSize);
    textAlign(RIGHT, CENTER);
    text(this.getLabel(), this.getX() + this.width / 3, this.getY() + this.height / 2);
    textAlign(LEFT, CENTER);
    text(this.getText(), this.getX() + this.width / 3, this.getY() + this.height / 2);
    this.keepInBox();
  }
}
