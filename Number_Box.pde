class Numberbox extends Textbox
{
  Numberbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont)
  {
    super(x, y, width, height, label, widgetColor, borderColor, labelColor, widgetFont);
  }
  
  public void editText()
  {
    if(this.getIsEditable())
    {
      if(key != CODED)
      {
        if(key == BACKSPACE && this.getText().length() > 0)
        {
          this.setText(this.getText().substring(0, this.getText().length() - 1));
        }
        else if( key != BACKSPACE && key != ENTER && key != TAB && key >= '0' && key <= '9')
        {
          this.setText(this.getText() + key);
        }
      }
    }
  }
}
