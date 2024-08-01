void settings()
{
  size(screenX, screenY);
}
void setup()
{
  loadResources();
}
void draw()
{
  background(WHITE);
  currentScreen.draw();
}
void mousePressed()
{
  for(int j = 0; j < allListBoxes.size(); j++)
  {
    Listbox l = allListBoxes.get(j);
    l.getScrollbar().getClicked(mouseX, mouseY);
    for(int i = 0; i < l.VISIBLE_OPTIONS; i++)
    {
      l.optionIsClicked(i, mouseX, mouseY);
    }
  }
  for(int i = 0; i < allButtons.size(); i++)
  {
    Button button = allButtons.get(i);
    button.isClicked(mouseX, mouseY);
  }
}
void mouseDragged()
{
  for(int j = 0; j < allListBoxes.size(); j++)
  {
    Listbox l = allListBoxes.get(j);
    l.getScrollbar().getDragged(mouseY, pmouseY);
  }
}
void mouseReleased()
{
  for(int j = 0; j < allListBoxes.size(); j++)
  {
    Listbox l = allListBoxes.get(j);
    l.getScrollbar().toggleRelease();
  }
}
void mouseMoved()
{
  
}
void keyPressed()
{
  for(int i = 0; i < allTextboxes.size(); i++)
  {
    Textbox textbox = allTextboxes.get(i);
    textbox.editText();
    textbox.stopEditing();
  }
}
