class Errorbox extends Widget
{
  private int width, height;
  private boolean showError;
  private Button exit;
  private int buttonWidth, buttonHeight;
  private int textSize;
  
  Errorbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont)
  {
    super(x, y, label, widgetColor, borderColor, labelColor, widgetFont);
    this.width = width;
    this.height = height;
    this.buttonWidth = this.width / 10;
    this.buttonHeight = this.height / 10;
    this.showError = false;
    this.textSize = 12;
    
    this.exit = new Button(this.getX() + this.width - this.buttonWidth, this.getY() + this.height - this.buttonHeight, buttonWidth, buttonHeight, "OK", WHITE, BLACK, BLACK, widgetFont, () -> stopError());
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
  public boolean getError()
  {
    return this.showError;
  }
  public void setError(boolean showError)
  {
    this.showError = showError;
  }
  public int getTextSize()
  {
    return this.textSize;
  }
  public void setTextSize(int textSize)
  {
    this.textSize = textSize;
  }
  public Button getOkButton()
  {
    return this.exit;
  }
  
  public void stopError()
  {
    this.setError(false);
  }
  public void draw()
  {
    if(this.getError())
    {
      stroke(this.getBorderColor());
      fill(this.getWidgetColor());
      rect(this.getX(), this.getY(), this.getWidth(), this.getHeight());
    
      fill(this.getLabelColor());
      textAlign(CENTER, CENTER);
      textSize(this.getTextSize());
      text(this.getLabel(), this.getX() + this.width / 2, this.getY() + this.height / 2);
    
      exit.draw();
    }
  }
}
