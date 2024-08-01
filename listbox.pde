import java.util.function.Consumer;

class Listbox extends Widget
{
  private Workout workout;
  private Exercise[] visibleItems;
  private int width, height, offset;
  private String label;
  final int VISIBLE_OPTIONS = 4;
  private int scrollbarWidth, scrollbarHeight;
  private int scrollbarX, scrollbarY;
  private int selected;
  private Scrollbar scrollbar;
  Consumer<Integer> optionClick;
  
  Listbox(int x, int y, int width, int height, String label, color widgetColor, color borderColor, color labelColor, PFont widgetFont, Workout workout, Consumer<Integer> optionClick)
  {
    super(x, y, "", widgetColor, borderColor, labelColor, widgetFont);
    this.width = width;
    this.height = height;
    this.label = label;
    this.optionClick = optionClick;
    this.offset = 0;
    this.selected = -1;
    this.visibleItems = new Exercise[VISIBLE_OPTIONS];
    
    this.scrollbarWidth = this.width / 10;
    this.scrollbarHeight = this.height * VISIBLE_OPTIONS;
    this.scrollbarX = x + this.width;
    this.scrollbarY = y;
    
    if(this.workout != null)
    {
      int limit = (this.workout.getExercises().size() > VISIBLE_OPTIONS ? this.workout.getExercises().size() : VISIBLE_OPTIONS);
      for(int i = 0; i < limit ; i++)
      {
        this.visibleItems[i] = this.workout.getExercises().get(i);
      }
      this.setupScrollbar();
    }
    
    
    
  }
  public void setupScrollbar()
  {
    double fraction = (double)VISIBLE_OPTIONS / (double)this.workout.getExercises().size();
    this.scrollbar = new Scrollbar(this.scrollbarX, this.scrollbarY, this.scrollbarWidth, this.scrollbarHeight, this.getWidgetColor(), BLACK, this.getWidgetFont(), fraction);
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
  public int getOffset()
  {
    return this.offset;
  }
  public void setOffset(int offset)
  {
    this.offset = offset;
  }
  public int getSelected()
  {
    return this.selected;
  }
  public void setSelected(int selected)
  {
    this.selected = selected;
  }
  public Workout getWorkout()
  {
    return this.workout;
  }
  public void setWorkout(Workout workout)
  {
    this.workout = workout;
    this.setupVisibleOptions();
  }
  public Exercise[] getVisibleItems()
  {
    return this.visibleItems;
  }
  public void setVisibleItems(Exercise[] visibleItems)
  {
    this.visibleItems = visibleItems;
  }
  public Scrollbar getScrollbar()
  {
    return this.scrollbar;
  }
  public void setupVisibleOptions()
  {
    int limit = (this.workout.getExercises().size() > VISIBLE_OPTIONS ? this.workout.getExercises().size() : VISIBLE_OPTIONS);
    
    this.visibleItems = new Exercise[limit];
    for(int i = 0; i < visibleItems.length; i++)
    {
      visibleItems[i] = this.workout.getExercises().get(i);
    }
  }
  
  public void optionIsClicked(int index, int mX, int mY)
  {
    
    if(index>= this.getVisibleItems().length) {return;}
    else
    {
      if(mX > this.getX() && mX < this.getX() + this.getWidth() && mY > this.getY() + this.getHeight() * (index) && mY < this.getY() + this.getHeight() * (index + 1))
      {
        if(this.getSelected() == index + this.getOffset())
        {
          this.setSelected(-1);
        }
        else
        {
          this.setSelected(index + this.getOffset());
          this.optionClick.accept(index + this.getOffset());
        }
      }
    }
  }
  public void updateVisibleOptions()
  {
    int value = this.getScrollbar().getValue();
    int diff = this.workout.getExercises().size() - VISIBLE_OPTIONS;
    int divisions = (this.scrollbar.getHeight() - this.scrollbar.getSliderHeight()) / (diff);
    
    for(int i = 0; i < diff; i++)
    {
      if(value > divisions * i && value <= divisions * (i + 1))
      {
        this.setOffset(i);
        for(int j = 0; j < VISIBLE_OPTIONS; j++)
        {
          this.visibleItems[j] = workout.getExercises().get(i + j);
        }
      }
    }
  }
  void draw()
  {
    int limit = (this.workout.getExercises().size() < VISIBLE_OPTIONS ? this.workout.getExercises().size() : VISIBLE_OPTIONS);
    for(int i = 0; i < limit; i++)
    {
      stroke(this.getBorderColor());
      fill(this.getWidgetColor());
      if(i == this.getSelected() - this.getOffset())
      {
        fill(GREEN);
      }
      rect(this.getX(), this.getY() + (this.getHeight() * i), this.getWidth(), this.getHeight());
      
      textAlign(CENTER, CENTER);
      textFont(this.getWidgetFont());
      textSize(16);
      fill(this.getLabelColor());
      text(this.visibleItems[i].getName(), this.getX() + this.getWidth() / 2, this.getY() + (this.getHeight() * i) + (this.getHeight() / 2));
    }
      
      if(this.workout.getExercises().size() > VISIBLE_OPTIONS)
      {
        scrollbar.draw();
        this.updateVisibleOptions();
      }
   } 
}
