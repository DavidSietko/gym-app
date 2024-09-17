import java.time.LocalDate;

int screenX = displayWidth;
int screenY = displayHeight;
final color WHITE = color(255);
final color BLACK = color(0);
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);
final color GREY = color(150);
final color LIGHT_BLUE = color(173, 216, 230);

int boxWidth;
int boxHeight;
int buttonWidth;
int buttonHeight;
PFont font;

String path = "data/";

Screen currentScreen;
SelectScreen selectScreen;
ExerciseScreen exerciseScreen;
EditScreen editScreen;
WorkoutScreen workoutScreen;

ArrayList<Button> selectScreenButtons;
ArrayList<Textbox> selectScreenTextboxes;

ArrayList<Listbox> exerciseScreenListboxes;
ArrayList<Button> exerciseScreenButtons;
ArrayList<Textbox> exerciseScreenTextboxes;

ArrayList<Button> editScreenButtons;
ArrayList<Textbox> editScreenTextboxes;
ArrayList<Listbox> editScreenListboxes;

ArrayList<Button> workoutScreenButtons;
ArrayList<Listbox> workoutScreenListboxes;

Workout currentWorkout;
Exercise currentExercise;
LocalDate today;
LocalDate currentDate;

void loadResources()
{
  screenX = displayWidth;
  screenY = displayHeight;
  boxWidth = displayWidth / 10;
  boxHeight = displayHeight / 20;
  buttonWidth = displayWidth / 10;
  buttonHeight = displayHeight / 5;
  font = loadFont("3ds-Light-48.vlw");
  today = LocalDate.now();
  currentDate = today;
  
  currentWorkout = loadWorkout(today.toString());
  currentExercise = new Exercise("");
  
  selectScreenButtons = new ArrayList<Button>();
  selectScreenTextboxes = new ArrayList<Textbox>();
  
  exerciseScreenButtons = new ArrayList<Button>();
  exerciseScreenListboxes = new ArrayList<Listbox>();
  exerciseScreenTextboxes = new ArrayList<Textbox>();
  
  editScreenButtons = new ArrayList<Button>();
  editScreenTextboxes = new ArrayList<Textbox>();
  editScreenListboxes = new ArrayList<Listbox>();
  
  workoutScreenButtons = new ArrayList<Button>();
  workoutScreenListboxes = new ArrayList<Listbox>();
  
  selectScreen = new SelectScreen();
  exerciseScreen = new ExerciseScreen();
  editScreen = new EditScreen();
  workoutScreen = new WorkoutScreen();
  if(currentWorkout.getName() == "")
  {
  currentScreen = selectScreen;
  }
  else
  {
    currentScreen = workoutScreen;
  }
  today = LocalDate.now();
}
