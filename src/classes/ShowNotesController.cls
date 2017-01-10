public class ShowNotesController {
public List<Note> NoteList = new List<Note>();
    public ShowNotesController(ApexPages.StandardController controller) {
    NoteList  = [SELECT Body,ParentId FROM Note];
    }

}