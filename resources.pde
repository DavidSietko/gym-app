import java.time.LocalDate;

int screenX = 2000;
int screenY = 1000;
final color WHITE = color(255);
final color BLACK = color(0);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color GREY = color(150);
final color LIGHT_BLUE = color(173, 216, 230);
final int buttonWidth = 200;
final int buttonHeight = 200;
PFont font;

Screen currentScreen;
SelectScreen selectScreen;
ExerciseScreen exerciseScreen;
ArrayList<Listbox> allListBoxes;
ArrayList<Button> allButtons;
ArrayList<Textbox> allTextboxes;
Workout currentWorkout;
Exercise currentExercise;

void isClicked(Integer index)
{
  print("i have been bressed" + index);
  print(allListBoxes.size());
}

void loadResources()
{
  font = loadFont("3ds-Light-48.vlw");
  currentWorkout = new Workout("");
  allButtons = new ArrayList<Button>();
  allListBoxes = new ArrayList<Listbox>();
  allTextboxes = new ArrayList<Textbox>();
  selectScreen = new SelectScreen();
  exerciseScreen = new ExerciseScreen();
  currentScreen = selectScreen;
}
