public class ConsumerService2{
 public static List<Book> ParseXML(string data){
        List<Book> listRecords = new List<Book>();
        XmlStreamReader xsr = new XmlStreamReader(data);
        listRecords = parseBooks(xsr);
        return listRecords ;
    }
 
    public static  List<Book> parseBooks(XmlStreamReader reader) {
    List<Book> books  = new List<Book>();    
        while(reader.hasNext()) { 
        //  Start at the beginning of the book and make sure that it is a book   
        if (reader.getEventType() == XmlTag.START_ELEMENT && 'bookdetail' == reader.getLocalName()) {
                Book book = parseBook(reader);                                //  Pass the book to the parseBook method (below)     
                books.add(book);
        }
        reader.next();
        }
    return books;
    }
   
   
    public static Book parseBook(XmlStreamReader reader) {
    //System.debug('@@@@@@@@@reader '+reader);
    Book book = new Book();
    List<BookId> bookIdList = new List<BookId>();
    //book.author = reader.getAttributeValue(null, 'author');
        while(reader.hasNext()) {
            if (reader.getEventType() == XmlTag.END_ELEMENT && 'bookdetail' == reader.getLocalName()) {
                break;
            } 
            if (reader.getEventType() == XmlTag.START_ELEMENT && 'book' == reader.getLocalName()) {
                book.author = reader.getAttributeValue(null, 'author');
            }
            
            if (reader.getEventType() == XmlTag.CHARACTERS) {
                book.name = getDecodedString(reader);
            }
            
            if (reader.getEventType() == XmlTag.START_ELEMENT &&  'BookIds' == reader.getLocalName()) { 
                //System.debug('@@@@@@@@@inside bookid');
                bookIdList.addAll(parseBookIds(reader));//  Pass the book to the parseBook method (below)     
                System.debug('@@@@@@@@@bookIdList'+bookIdList);
            } 
            
        reader.next();
        }
    book.bookIdList = bookIdList ;
    return book;
    }
   
   
    public static List<BookId> parseBookIds(XmlStreamReader reader) {
    //System.debug('@@@@@@@@@reader '+reader);
    List<BookId> bookIdList = new List<BookId>();
    //book.author = reader.getAttributeValue(null, 'author');
        while(reader.hasNext()) {
        if (reader.getEventType() == XmlTag.END_ELEMENT && 'BookIds' == reader.getLocalName()) {
            break;
        } 
        BookId bookId = new BookId();
            if (reader.getEventType() == XmlTag.START_ELEMENT && 'bookType' == reader.getLocalName()) {
                //bookId.IdType = reader.getAttributeValue(null, 'type');
                
                while(reader.hasNext()) {   
                    if (reader.getEventType() == XmlTag.END_ELEMENT) {
                        break;
                    }
                    if (reader.getEventType() == XmlTag.START_ELEMENT && 'bookType' == reader.getLocalName()) {
                        bookId.IdType = reader.getAttributeValue(null, 'type');
                    }
                    
                    if (reader.getEventType() == XmlTag.CHARACTERS) {
                        bookId.Idvalue = getDecodedString(reader);
                    }
                    //System.debug('@@@@@@@@@@@bookId '+bookId);         
                reader.next();
                }
                bookIdList.add(bookId); 
            }
        reader.next();
        }
    return bookIdList ;
    }
   
   
   
   
    static String getDecodedString(Xmlstreamreader reader){
        return EncodingUtil.urlDecode(reader.getText(), 'UTF-8').trim();
    }
    
    public class Book {
        String name;
        String author;
        List<BookId> BookIdList;
    }
    
    public class BookId {
        String IdType;
        String IdValue;
    }
}