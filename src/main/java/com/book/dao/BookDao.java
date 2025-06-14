package com.book.dao;

import com.book.domain.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

@Repository
public class BookDao {

    private JdbcTemplate jdbcTemplate;

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final static String ADD_BOOK_SQL="INSERT INTO book_info VALUES(NULL ,?,?,?,?,?,?,?,?,?,?,?)";
    private final static String DELETE_BOOK_SQL="delete from book_info where book_id = ?  ";
    private final static String EDIT_BOOK_SQL="update book_info set name= ? ,author= ? ,publish= ? ,ISBN= ? ,introduction= ? ,language= ? ,price= ? ,pubdate= ? ,class_id= ? ,pressmark= ? ,state= ?  where book_id= ? ;";
    private final static String QUERY_ALL_BOOKS_SQL="SELECT * FROM book_info ";    private final static String QUERY_BOOK_SQL="SELECT * FROM book_info WHERE CAST(book_id AS CHAR) like ? or name like ? or author like ? or publish like ?";
    //查询匹配图书的个数
    private final static String MATCH_BOOK_SQL="SELECT count(*) FROM book_info WHERE CAST(book_id AS CHAR) like ? or name like ? or author like ? or publish like ?";
    //根据书号查询图书
    private final static String GET_BOOK_SQL="SELECT * FROM book_info where book_id = ? ";    public int matchBook(String searchWord){
        String swcx="%"+searchWord+"%";
        System.out.println("=== BookDao.matchBook 调试信息 ===");
        System.out.println("原始搜索词: " + searchWord);
        System.out.println("SQL通配符搜索词: " + swcx);
        System.out.println("执行SQL: " + MATCH_BOOK_SQL);
        int count = jdbcTemplate.queryForObject(MATCH_BOOK_SQL,new Object[]{swcx,swcx,swcx,swcx},Integer.class);
        System.out.println("匹配到的记录数: " + count);
        return count;
    }    public ArrayList<Book> queryBook(String sw){
        String swcx="%"+sw+"%";
        System.out.println("=== BookDao.queryBook 调试信息 ===");
        System.out.println("原始搜索词: " + sw);
        System.out.println("SQL通配符搜索词: " + swcx);
        System.out.println("执行SQL: " + QUERY_BOOK_SQL);
        
        final ArrayList<Book> books=new ArrayList<Book>();
        jdbcTemplate.query(QUERY_BOOK_SQL, new Object[]{swcx,swcx,swcx,swcx}, new RowCallbackHandler() {
            public void processRow(ResultSet resultSet) throws SQLException {
                Book book =new Book();
                book.setAuthor(resultSet.getString("author"));
                book.setBookId(resultSet.getLong("book_id"));
                book.setClassId(resultSet.getInt("class_id"));
                book.setIntroduction(resultSet.getString("introduction"));
                book.setIsbn(resultSet.getString("ISBN"));
                book.setLanguage(resultSet.getString("language"));
                book.setName(resultSet.getString("name"));
                book.setPressmark(resultSet.getInt("pressmark"));
                book.setPubdate(resultSet.getDate("pubdate"));
                book.setPrice(resultSet.getBigDecimal("price"));
                book.setState(resultSet.getInt("state"));
                book.setPublish(resultSet.getString("publish"));
                books.add(book);
                System.out.println("找到图书: ID=" + book.getBookId() + ", 书名=" + book.getName() + ", 作者=" + book.getAuthor());
            }
        });
        System.out.println("总共找到 " + books.size() + " 本图书");
        return books;
    }    public ArrayList<Book> getAllBooks(){
        final ArrayList<Book> books=new ArrayList<Book>();

        jdbcTemplate.query(QUERY_ALL_BOOKS_SQL, new RowCallbackHandler() {
            public void processRow(ResultSet resultSet) throws SQLException {
                Book book =new Book();
                book.setPrice(resultSet.getBigDecimal("price"));
                book.setState(resultSet.getInt("state"));
                book.setPublish(resultSet.getString("publish"));
                book.setPubdate(resultSet.getDate("pubdate"));
                book.setName(resultSet.getString("name"));
                book.setIsbn(resultSet.getString("ISBN"));
                book.setClassId(resultSet.getInt("class_id"));
                book.setBookId(resultSet.getLong("book_id"));
                book.setAuthor(resultSet.getString("author"));
                book.setIntroduction(resultSet.getString("introduction"));
                book.setPressmark(resultSet.getInt("pressmark"));
                book.setLanguage(resultSet.getString("language"));
                books.add(book);
            }
        });
        return books;

    }

    public int deleteBook(long bookId){

        return jdbcTemplate.update(DELETE_BOOK_SQL,bookId);
    }

    public int addBook(Book book){
        String name=book.getName();
        String author=book.getAuthor();
        String publish=book.getPublish();
        String isbn=book.getIsbn();
        String introduction=book.getIntroduction();
        String language=book.getLanguage();
        BigDecimal price=book.getPrice();
        Date pubdate=book.getPubdate();
        int classId=book.getClassId();
        int pressmark=book.getPressmark();
        int state=book.getState();

        return jdbcTemplate.update(ADD_BOOK_SQL,new Object[]{name,author,publish,isbn,introduction,language,price,pubdate,classId,pressmark,state});
    }    public Book getBook(Long bookId){
        final Book book =new Book();
        jdbcTemplate.query(GET_BOOK_SQL, new Object[]{bookId}, new RowCallbackHandler() {
            public void processRow(ResultSet resultSet) throws SQLException {
                    book.setAuthor(resultSet.getString("author"));
                    book.setBookId(resultSet.getLong("book_id"));
                    book.setClassId(resultSet.getInt("class_id"));
                    book.setIntroduction(resultSet.getString("introduction"));
                    book.setIsbn(resultSet.getString("ISBN"));
                    book.setLanguage(resultSet.getString("language"));
                    book.setName(resultSet.getString("name"));
                    book.setPressmark(resultSet.getInt("pressmark"));
                    book.setPubdate(resultSet.getDate("pubdate"));
                    book.setPrice(resultSet.getBigDecimal("price"));
                    book.setState(resultSet.getInt("state"));
                    book.setPublish(resultSet.getString("publish"));
            }

        });
        return book;
    }
    public int editBook(Book book){
        Long bookId=book.getBookId();
        String name=book.getName();
        String author=book.getAuthor();
        String publish=book.getPublish();
        String isbn=book.getIsbn();
        String introduction=book.getIntroduction();
        String language=book.getLanguage();
        BigDecimal price=book.getPrice();
        Date pubdate=book.getPubdate();
        int classId=book.getClassId();
        int pressmark=book.getPressmark();
        int state=book.getState();

        return jdbcTemplate.update(EDIT_BOOK_SQL,new Object[]{name,author,publish,isbn,introduction,language,price,pubdate,classId,pressmark,state,bookId});
    }


}
