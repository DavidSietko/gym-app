abstract class Screen
{
  private ArrayList<Widget> widgetList;
  Screen(){}
  
  void addWidget(Widget widget)
  {
    widgetList.add(widget);
  }
  void removeWidget(Widget widget)
  {
    widgetList.remove(widget);
  }
  public ArrayList<Widget> getWidgets()
  {
    return this.widgetList;
  }
  public void setWidgetList(ArrayList<Widget> widgetList)
  {
    this.widgetList = widgetList;
  }
  
  public void draw() {}
}
