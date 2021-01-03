/// Used to get note changes after notes page is popped
///
/// The notes page is dismissed by tapping the barrier of the modal route.
/// Since there is no way to return a value when the barrier is clicked
/// (as far as I know) this object is used to retrieve the changes
class NotesMessenger {
  String notes;

  NotesMessenger({this.notes});
}
