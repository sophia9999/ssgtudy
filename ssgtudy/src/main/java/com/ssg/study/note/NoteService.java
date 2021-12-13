package com.ssg.study.note;

import java.util.List;
import java.util.Map;

public interface NoteService {
	public List<Note> listFriend(Map<String, Object> map);
	
	public void insertNote(Note dto) throws Exception;
	
	public int dataCountReceive(Map<String, Object> map);
	public List<Note> listReceive(Map<String, Object> map);
	
	public int dataCountSend(Map<String, Object> map);
	public List<Note> listSend(Map<String, Object> map);
	
	public Note readReceive(int num);
	public Note preReadReceive(Map<String, Object> map);
	public Note nextReadReceive(Map<String, Object> map);
	
	public Note readSend(int num);
	public Note preReadSend(Map<String, Object> map);
	public Note nextReadSend(Map<String, Object> map);
	
	public void updateIdentifyDay(int num) throws Exception;
	
	public void deleteNote(Map<String, Object> map) throws Exception;
	
	public int newNoteCount(String userId);
	
	
	
}
