public class XmlStreamReaderDemo {
    // Create a class Book for processing
    public class Book {
        String key;
        String value;
    }
    
   

    public List<Book> parseBooks(XmlStreamReader reader) {
        //List of Attributes
        List<string> attributeList = new List<string>();
        attributeList.add('faultCode');
        attributeList.add('faultLocation');
       
        
                
        List<Book> books = new List<Book>();
        
        
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            //System.debug('@@@@@@@@@reader.getEventType() '+reader.getEventType());
            // Start at the beginning of the book and make sure that it is a book
            if(reader.getEventType() == XmlTag.START_ELEMENT && reader.getAttributeValue(null, 'name') == 'Books') {
                for(string attributename : attributeList){
                    if(reader.getEventType() == XmlTag.START_ELEMENT && reader.getAttributeValue(null, 'name') == attributename) {
                        // Pass the book to the parseBook method (below) 
                        Book book = parseBook(reader);
                        books.add(book);
                    }
                }
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return books;
    }

    // Parse through the XML, determine the author and the characters
    Book parseBook(XmlStreamReader reader) {
        Book book = new Book();
        book.key = reader.getAttributeValue(null, 'name');
        
        boolean isSafeToGetNextXmlElement = true;
        while(isSafeToGetNextXmlElement) {
            if (reader.getEventType() == XmlTag.END_ELEMENT){
                break;
            } else if (reader.getEventType() == XmlTag.CHARACTERS){
                book.value = reader.getText();
                //book.name = reader.getAttributeValue(null, 'name');
            }
            // Always use hasNext() before calling next() to confirm 
            // that we have not reached the end of the stream
            if (reader.hasNext()) {
                reader.next();
            } else {
                isSafeToGetNextXmlElement = false;
                break;
            }
        }
        return book;
    }
}



/*

String str = '<?xml version="1.0" encoding="UTF-8"?>'+
'<xsd:schema targetNamespace="http://com/firstdata/services/merchant" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+ 
    '<xsd:element name="books">'+
        '<xsd:element name="book1" author="Chatty">Foo bar</xsd:element>' +
        '<xsd:element name="book2" author="Sassy">Baz</xsd:element>'+
    '</xsd:element>'+
'</xsd:schema>';

XmlStreamReaderDemo demo = new XmlStreamReaderDemo();
XmlStreamReader reader = new XmlStreamReader(str);
XmlStreamReaderDemo.Book[] books = demo.parseBooks(reader);

System.debug('@@@@@@@@@@@@@@@@books.size() '+books.size());

for (XmlStreamReaderDemo.Book book : books) {
    System.debug('@@@@@@@@@@@@@@@@book '+book);
}





*/