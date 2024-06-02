package com.example.oop_laba10;


import com.example.oop_laba10.models.Song;
import com.google.gson.Gson;
import org.json.JSONArray;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/songs_table")
public class SongsController extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/oop_songs_db";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "root";

    List<Song> songs = null;

    @Override
    protected  void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        songs = getAllSongsFromDB();
        Gson gson = new Gson();

        String jsonString = gson.toJson(songs);
        JSONArray array = new JSONArray(jsonString);

        String fullPath;
        try {
            fullPath = new File(SongsController.class.getProtectionDomain().getCodeSource().getLocation().toURI()).getParentFile().getParentFile().getParentFile().getParent();
            fullPath += File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "songs.json";
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }

        try(FileWriter writer = new FileWriter(fullPath)){
            writer.write(array.toString(4));
            writer.flush();
            writer.close();
        } catch (IOException ex){
            System.out.println("full Error!!!");
            ex.printStackTrace();
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher("view/songs.jsp");
        requestDispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        if(req.getParameter("song_id")  != null){
            deleteSongInDb(req.getParameter("song_id"));
        }else{
            if(req.getParameter("new_song_name") != null){
                Song song = new Song( //getting new song object from view
                        req.getParameter("id"),
                        req.getParameter("new_song_name"),
                        req.getParameter("new_author"),
                        req.getParameter("new_album"),
                        req.getParameter("new_length"),
                        req.getParameter("new_year")
                );

                updateSongInDB(song);

            }else{
                Song song = new Song( //getting new song object from view
                        "0",
                        req.getParameter("song_name"),
                        req.getParameter("author"),
                        req.getParameter("album"),
                        req.getParameter("length"),
                        req.getParameter("year")
                );

                addSongToDB(song);
            }
        }

        doGet(req, resp);
    }

    private List<Song> getAllSongsFromDB(){
        List<Song> songs = new ArrayList<>();
        Connection connection;

        try {
            Driver driver = new com.mysql.cj.jdbc.Driver();
            DriverManager.registerDriver(driver);
            connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            if(!connection.isClosed())
                System.out.println("Successfully connected!");

            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("select * from songs");

            while(resultSet.next()){
                songs.add(
                        new Song(
                        "" + resultSet.getInt("id"),
                        resultSet.getString("songName"),
                        resultSet.getString("author"),
                        resultSet.getString("album"),
                        resultSet.getString("length"),
                        resultSet.getString("year")
                        )
                );
            }

            connection.close();
        } catch (SQLException e) {
            System.out.println("Connection to DB failed!");
        }

        return songs;
    }

    private void addSongToDB(Song song){
        Connection connection;
        String insertQuery = "insert into songs (songName, author, album, length, year) values (?, ?, ?, ?, ?)";
        try{
            Driver driver = new com.mysql.cj.jdbc.Driver();
            DriverManager.registerDriver(driver);
            connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            if(!connection.isClosed())
                System.out.println("Ready to insert new song");

            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);

            preparedStatement.setString(1, song.getSongName());
            preparedStatement.setString(2, song.getAuthor());
            preparedStatement.setString(3, song.getAlbum());
            preparedStatement.setString(4, song.getLength());
            preparedStatement.setString(5, song.getYear());

            preparedStatement.executeUpdate();

            connection.close();
        }catch (SQLException e){
            System.out.println("Can't add object to DB!");
        }
    }

    private void updateSongInDB(Song song){
        Connection connection;
        String updateQuery = "update songs set songName = ?, author = ?, album = ?, length = ?, year = ? where id = ?";
        try{
            Driver driver = new com.mysql.cj.jdbc.Driver();
            DriverManager.registerDriver(driver);
            connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            if(!connection.isClosed())
                System.out.println("Ready to update!");

            PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);

            preparedStatement.setString(1, song.getSongName());
            preparedStatement.setString(2, song.getAuthor());
            preparedStatement.setString(3, song.getAlbum());
            preparedStatement.setString(4, song.getLength());
            preparedStatement.setString(5, song.getYear());
            preparedStatement.setInt(6, Integer.parseInt(song.getId()));

            preparedStatement.executeUpdate();

            connection.close();
        }catch (SQLException e){
            System.out.println("Can't update object in DB!");
        }
    }

    private void deleteSongInDb(String deletedSongId){
        Connection connection;
        String deleteQuery = "delete from songs where id = ?";
        try{
            Driver driver = new com.mysql.cj.jdbc.Driver();
            DriverManager.registerDriver(driver);
            connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            if(!connection.isClosed())
                System.out.println("Ready to delete");

            PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);

            preparedStatement.setString(1, deletedSongId);

            preparedStatement.executeUpdate();

            connection.close();
        }catch (SQLException e){
            System.out.println("Can't delete object in DB!");
        }
    }
}
