package com.codegym.case_module3.controller;

import com.codegym.case_module3.model.Account;
import com.codegym.case_module3.model.Author;
import com.codegym.case_module3.model.Book;
import com.codegym.case_module3.model.Category;
import com.codegym.case_module3.service.book.BookService;
import com.google.gson.Gson;
import com.codegym.case_module3.service.author.AuthorService;
import com.codegym.case_module3.service.category.CategoryService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;

@WebServlet(name = "BookServlet", urlPatterns = "/books")
public class BookController extends HttpServlet {
    BookService bookService;
    CategoryService categoryService;
    AuthorService authorService;
    private Gson gson = new Gson();
    private HttpSession session;
    private Account curUser;

    @Override
    public void init() {
        bookService = BookService.getInstance();
        categoryService = CategoryService.getInstance();
        authorService = AuthorService.getInstance();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        session = request.getSession();
        curUser = (Account) session.getAttribute("user");
        request.setAttribute("currentUser", curUser);

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    showFormCreate(request, response);
                    break;
                case "edit":
                    showFormEdit(request, response);
                    break;
                case "delete":
                    deleteBooks(request, response);
                    break;
                case "shop":
                    shopPage(request, response);
                    break;
                case "get_books_API":
                    getBookAPI(request, response);
                    break;
                case "getTop4ByCategory":
                    getTop4ByCategory(request, response);
                    break;
                case "categoryID":
                    getBookByCategory(request, response);
                    break;
                default:
                    showAllBook(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void searchByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("searchBook");

        if(name == null){
            name = "%%";
        }
        else {
            name = "%" + name+ "%";
        }
        HashMap<Integer, Book> books = bookService.findNameBook(name);
        HashMap<Integer, Category> categories = categoryService.find("");
        HashMap<Integer, Author> authors = authorService.find("");
        request.setAttribute("listBook", books.values());
        request.setAttribute("categories", categories.values());
        request.setAttribute("authors", authors.values());
        RequestDispatcher resRequestDispatcher = request.getRequestDispatcher("views/book/list.jsp");
        resRequestDispatcher.forward(request, response);
    }
    private void getTop4ByCategory(HttpServletRequest request, HttpServletResponse response) {
        String catId = request.getParameter("catId");
        HashMap<Integer, Book> bookHashMap = bookService.findTop4ByCategory(Integer.parseInt(catId));
        String bookData = gson.toJson(bookHashMap.values());
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(bookData);
        out.flush();
    }

    private void getBookByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        HashMap<Integer, Book> books = bookService.findByCategory(id);
        HashMap<Integer, Category> categories = categoryService.find("");
        HashMap<Integer, Author> authors = authorService.find("");
        request.setAttribute("categories", categories.values());
        request.setAttribute("authors", authors.values());
        request.setAttribute("listBook", books.values());
        RequestDispatcher resRequestDispatcher = request.getRequestDispatcher("views/book/list.jsp");
        resRequestDispatcher.forward(request, response);
    }

    private void shopPage(HttpServletRequest request, HttpServletResponse response) {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("ashion-master/shop.jsp");
        try {
            requestDispatcher.forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void getBookAPI(HttpServletRequest request, HttpServletResponse response) {
        String condition = "";
        String pageStr = request.getParameter("page");
        int page = 0;
        if (pageStr != null) {
            page = Integer.parseInt(pageStr) - 1;
        }
        String minpStr = request.getParameter("minp");
        String maxpStr = request.getParameter("maxp");
        if (minpStr != null && maxpStr != null) {
            int minp = Integer.parseInt(minpStr.replace("$", ""));
            int maxp = Integer.parseInt(maxpStr.replace("$", ""));
            condition = "WHERE price BETWEEN " + minp + " and " + maxp;
        }
        String catId = request.getParameter("catId");
        if (catId != null) {
            condition = "WHERE category_id = " + catId;
        }
        condition += " LIMIT " + page * 9 + ", " + 9;
        HashMap<Integer, Book> bookHashMap = bookService.find(condition);
        String bookData = gson.toJson(bookHashMap.values());
        PrintWriter out = null;
        try {
            out = response.getWriter();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        out.print(bookData);
        out.flush();
    }

    private void deleteBooks(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookService.delete(id);
        response.sendRedirect("/books?page=1");

    }

    private void showFormEdit(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = bookService.findById(id);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("views/book/edit.jsp");
        request.setAttribute("book", book);
        requestDispatcher.forward(request, response);
    }

    private void showFormCreate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HashMap<Integer, Category> categories = categoryService.find("");
        HashMap<Integer, Author> authors = authorService.find("");
        request.setAttribute("categories", categories.values());
        request.setAttribute("authors", authors.values());
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("views/book/create.jsp");
        requestDispatcher.forward(request, response);
    }

    private void showAllBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = Integer.parseInt(request.getParameter("page"));
        String condition = " LIMIT " + (page * 6) + ", " + 6;

        HashMap<Integer, Book> books = bookService.find(condition);
        HashMap<Integer, Book> size = bookService.find("");
        HashMap<Integer, Category> categories = categoryService.find("");
        HashMap<Integer, Author> authors = authorService.find("");
        request.setAttribute("categories", categories.values());
        request.setAttribute("authors", authors.values());
        request.setAttribute("listBook", books.values());
        request.setAttribute("size", size.values().size());
        RequestDispatcher resRequestDispatcher = request.getRequestDispatcher("views/book/list.jsp");
        resRequestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "create":
                    createBook(request, response);
                    break;
                case "edit":
                    editBook(request, response);
                    break;
                case "delete":
                    deleteBooks(request, response);
                    break;
                case "search":
                    searchByName(request, response);
                    break;
                default:
                    showAllBook(request, response);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Book getAllBook(HttpServletRequest request, HttpServletResponse response,String name) {
        String title = request.getParameter("title"+name);
        int categoryId = Integer.parseInt(request.getParameter("categoryId"+name));
        int authorId = Integer.parseInt(request.getParameter("authorId"+name));
        int publishYear = Integer.parseInt(request.getParameter("publishYear"+name));
        String description = request.getParameter("description"+name);
        String image = request.getParameter("image"+name);
        int views = Integer.parseInt(request.getParameter("views"+name));
        int quantity = Integer.parseInt(request.getParameter("quantity"+name));
        double price = Double.parseDouble(request.getParameter("price"+name));
        Category category = categoryService.findById(categoryId);
        Author author = authorService.findById(authorId);
        return new Book(title, author, category, publishYear, image, description, price, views, quantity);
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Book book = getAllBook(request, response,"Edit");
        int id = Integer.parseInt(request.getParameter("id"));
        book.setId(id);
        bookService.update(book);
        response.sendRedirect("/books?page=1");
    }

    private void createBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Book book = getAllBook(request, response,"");
        bookService.create(book);
        response.sendRedirect("/books?page=1");

    }
}
