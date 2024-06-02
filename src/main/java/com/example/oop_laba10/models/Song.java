package com.example.oop_laba10.models;

public class Song {
    private String id;
    private String songName;
    private String author;
    private String album;
    private String length;
    private String year;

    public Song(String id, String songName, String author, String album, String length, String year){
        this.id = id;
        this.songName = songName;
        this.author = author;
        this.album = album;
        this.length = length;
        this.year = year;
    }

    public String getAuthor() {
        return author;
    }

    public String getAlbum() {
        return album;
    }

    public String getSongName() {
        return songName;
    }

    public String getYear() {
        return year;
    }

    public String getLength() {
        return length;
    }

    public String getId() {
        return id;
    }
}
