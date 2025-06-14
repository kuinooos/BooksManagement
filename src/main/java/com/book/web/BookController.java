package com.book.web;

import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;

@Controller
public class BookController {
    private BookService bookService;    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }
    
    @RequestMapping(value = "/querybook.html", method = RequestMethod.POST)
    public ModelAndView queryBookDo(HttpServletRequest request,String searchWord){
        try {
            // 设置请求编码
            request.setCharacterEncoding("UTF-8");
            
            System.out.println("=== 图书搜索详细调试信息 ===");
            System.out.println("原始接收到的搜索关键字: " + searchWord);
            System.out.println("搜索关键字是否为null: " + (searchWord == null));
            
            if (searchWord != null) {
                System.out.println("搜索关键字长度: " + searchWord.length());
                System.out.println("搜索关键字字节长度: " + searchWord.getBytes().length);
                System.out.println("搜索关键字UTF-8字节长度: " + searchWord.getBytes("UTF-8").length);
                System.out.println("搜索关键字字符数组: " + java.util.Arrays.toString(searchWord.toCharArray()));
                
                // 尝试重新编码 - 从ISO-8859-1转换为UTF-8
                try {
                    String utf8SearchWord = new String(searchWord.getBytes("ISO-8859-1"), "UTF-8");
                    System.out.println("重新编码后的搜索关键字: " + utf8SearchWord);
                    
                    // 如果重新编码后的字符串包含中文字符，则使用重新编码的版本
                    if (!utf8SearchWord.equals(searchWord) && utf8SearchWord.matches(".*[\\u4e00-\\u9fa5].*")) {
                        System.out.println("检测到中文字符，使用重新编码的关键字");
                        searchWord = utf8SearchWord;
                    }
                } catch (Exception e) {
                    System.out.println("编码转换失败: " + e.getMessage());
                }
            }
            
            boolean exist=bookService.matchBook(searchWord);
            System.out.println("是否找到匹配图书: " + exist);
            
            if (exist){
                ArrayList<Book> books = bookService.queryBook(searchWord);
                System.out.println("找到图书数量: " + books.size());
                for (Book book : books) {
                    System.out.println("图书ID: " + book.getBookId() + ", 书名: " + book.getName() + ", 作者: " + book.getAuthor());
                }
                ModelAndView modelAndView = new ModelAndView("admin_books");
                modelAndView.addObject("books",books);
                return modelAndView;
            }
            else{
                System.out.println("没有找到匹配的图书");
                return new ModelAndView("admin_books","error","没有匹配的图书");
            }
        } catch (Exception e) {
            System.out.println("搜索过程中发生异常: " + e.getMessage());
            e.printStackTrace();
            return new ModelAndView("admin_books","error","搜索过程中发生错误: " + e.getMessage());
        }
    }    @RequestMapping("/reader_querybook.html")
    public ModelAndView readerQueryBook(){
       return new ModelAndView("reader_book_query");

    }
    
    @RequestMapping(value = "/reader_querybook_do.html", method = RequestMethod.POST)
    public String readerQueryBookDo(HttpServletRequest request,String searchWord,RedirectAttributes redirectAttributes){
        boolean exist=bookService.matchBook(searchWord);
        if (exist){
            ArrayList<Book> books = bookService.queryBook(searchWord);
            redirectAttributes.addFlashAttribute("books", books);
            return "redirect:/reader_querybook.html";
        }
        else{
            redirectAttributes.addFlashAttribute("error", "没有匹配的图书！");
            return "redirect:/reader_querybook.html";
        }

    }

    @RequestMapping("/allbooks.html")
    public ModelAndView allBook(){
        ArrayList<Book> books=bookService.getAllBooks();
        ModelAndView modelAndView=new ModelAndView("admin_books");
        modelAndView.addObject("books",books);
        return modelAndView;
    }
    @RequestMapping("/deletebook.html")
    public String deleteBook(HttpServletRequest request,RedirectAttributes redirectAttributes){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        int res=bookService.deleteBook(bookId);

        if (res==1){
            redirectAttributes.addFlashAttribute("succ", "图书删除成功！");
            return "redirect:/allbooks.html";
        }else {
            redirectAttributes.addFlashAttribute("error", "图书删除失败！");
            return "redirect:/allbooks.html";
        }
    }    @RequestMapping("/book_add.html")
    public ModelAndView addBook(HttpServletRequest request){

            return new ModelAndView("admin_book_add");

    }
    
    @RequestMapping(value = "/book_add_do.html", method = RequestMethod.POST)
    public String addBookDo(BookAddCommand bookAddCommand, RedirectAttributes redirectAttributes, Model model){
        try {
            // 日志记录接收到的参数
            System.out.println("接收到的图书信息：");
            System.out.println("书名: " + bookAddCommand.getName());
            System.out.println("作者: " + bookAddCommand.getAuthor());
            System.out.println("价格: " + bookAddCommand.getPrice());
            System.out.println("分类号: " + bookAddCommand.getClassId());
            System.out.println("书架号: " + bookAddCommand.getPressmark());
            System.out.println("状态: " + bookAddCommand.getState());
            System.out.println("出版日期: " + bookAddCommand.getPubdate());
            
            // 验证必填字段 - 返回到添加页面而不是重定向
            if (bookAddCommand.getName() == null || bookAddCommand.getName().trim().isEmpty()) {
                model.addAttribute("error", "书名不能为空！");
                model.addAttribute("bookAddCommand", bookAddCommand); // 保留用户输入
                return "admin_book_add";
            }
            if (bookAddCommand.getAuthor() == null || bookAddCommand.getAuthor().trim().isEmpty()) {
                model.addAttribute("error", "作者不能为空！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getPrice() == null || bookAddCommand.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
                model.addAttribute("error", "价格必须大于0！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getPublish() == null || bookAddCommand.getPublish().trim().isEmpty()) {
                model.addAttribute("error", "出版社不能为空！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getIsbn() == null || bookAddCommand.getIsbn().trim().isEmpty()) {
                model.addAttribute("error", "ISBN不能为空！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getIsbn().length() < 10 || bookAddCommand.getIsbn().length() > 20) {
                model.addAttribute("error", "请输入有效的ISBN号码（10-20个字符）！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getClassId() <= 0) {
                model.addAttribute("error", "分类号必须是正整数！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
            if (bookAddCommand.getPressmark() <= 0) {
                model.addAttribute("error", "书架号必须是正整数！");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }            
            Book book=new Book();
            book.setBookId(0);
            book.setPrice(bookAddCommand.getPrice());
            book.setState(bookAddCommand.getState());
            book.setPublish(bookAddCommand.getPublish());
            book.setPubdate(bookAddCommand.getPubdate());
            book.setName(bookAddCommand.getName());
            book.setIsbn(bookAddCommand.getIsbn());
            book.setClassId(bookAddCommand.getClassId());
            book.setAuthor(bookAddCommand.getAuthor());
            book.setIntroduction(bookAddCommand.getIntroduction());
            book.setPressmark(bookAddCommand.getPressmark());
            book.setLanguage(bookAddCommand.getLanguage());

            boolean succ=bookService.addBook(book);
            if (succ){
                redirectAttributes.addFlashAttribute("succ", "图书添加成功！");
                return "redirect:/allbooks.html";
            } else {
                model.addAttribute("error", "图书添加失败！可能是数据库连接问题或数据重复。");
                model.addAttribute("bookAddCommand", bookAddCommand);
                return "admin_book_add";
            }
        } catch (Exception e) {
            // 处理数据转换错误等异常
            e.printStackTrace();
            System.err.println("图书添加异常: " + e.getMessage());
            model.addAttribute("error", "数据格式错误，请检查输入的信息！异常信息：" + e.getMessage());
            model.addAttribute("bookAddCommand", bookAddCommand); // 保留用户输入
            return "admin_book_add";
        }
    }    @RequestMapping("/updatebook.html")
    public ModelAndView bookEdit(HttpServletRequest request){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        Book book=bookService.getBook(bookId);
        ModelAndView modelAndView=new ModelAndView("admin_book_edit");
        modelAndView.addObject("detail",book);
        return modelAndView;
    }
    
    @RequestMapping(value = "/book_edit_do.html", method = RequestMethod.POST)
    public String bookEditDo(HttpServletRequest request,BookAddCommand bookAddCommand,RedirectAttributes redirectAttributes){
        long bookId=Integer.parseInt( request.getParameter("id"));
        Book book=new Book();
        book.setBookId(bookId);
        book.setPrice(bookAddCommand.getPrice());
        book.setState(bookAddCommand.getState());
        book.setPublish(bookAddCommand.getPublish());
        book.setPubdate(bookAddCommand.getPubdate());
        book.setName(bookAddCommand.getName());
        book.setIsbn(bookAddCommand.getIsbn());
        book.setClassId(bookAddCommand.getClassId());
        book.setAuthor(bookAddCommand.getAuthor());
        book.setIntroduction(bookAddCommand.getIntroduction());
        book.setPressmark(bookAddCommand.getPressmark());
        book.setLanguage(bookAddCommand.getLanguage());


        boolean succ=bookService.editBook(book);
        if (succ){
            redirectAttributes.addFlashAttribute("succ", "图书修改成功！");
            return "redirect:/allbooks.html";
        }
        else {
            redirectAttributes.addFlashAttribute("error", "图书修改失败！");
            return "redirect:/allbooks.html";
        }
    }


    @RequestMapping("/bookdetail.html")
    public ModelAndView bookDetail(HttpServletRequest request){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        Book book=bookService.getBook(bookId);
        ModelAndView modelAndView=new ModelAndView("admin_book_detail");
        modelAndView.addObject("detail",book);
        return modelAndView;
    }



    @RequestMapping("/readerbookdetail.html")
    public ModelAndView readerBookDetail(HttpServletRequest request){
        long bookId=Integer.parseInt(request.getParameter("bookId"));
        Book book=bookService.getBook(bookId);
        ModelAndView modelAndView=new ModelAndView("reader_book_detail");
        modelAndView.addObject("detail",book);
        return modelAndView;
    }



}
