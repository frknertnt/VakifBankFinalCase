# Bayi Yönetim ve Sipariş Sistemi

Tanıtım Linki: https://www.youtube.com/watch?v=U6LO1-F6rqE

![App Screenshot](https://github.com/frknertnt/VakifBankFinalCase/blob/main/ImageForApp/b2bphoto.png)

Bu sistem, bayilerin siparişlerini yönetmelerine, ürün stok durumlarını ve onlara özel fiyatları görüntülemelerine ve ödemelerini gerçekleştirmelerine olanak tanıyan tam entegre bir çözümdür. B2B (Bussiness-to-Bussiness) olarak bilinen bu sistem şirketten şirkete e-ticaret sistemi sunar. Şirket (admin) sisteme ürünlerini ekledikten sonra bayilere özel fiyatlar oluşturmak için ilk olarak fiyat listesi oluşturur ardından bu fiyat listesi üzerinden bayiyle ilişki kurar ve bayi ona özel fiyatlar ile ürün alışverişi yapar.
## Başlangıç

### Ön Koşullar

- .NET 6.0
- Angular 16.2.0
- MSSQL veritabanı

### Kurulum

1. Projeyi klonlayın:
    ```
    git clone [repo-link]
    ```
2. Database backup ve script dosyalarını veritabanınıza yükleyin.
3. API için gerekli NuGet paketlerini yükleyin:
4. Angular uygulaması için gerekli npm paketlerini yükleyin
5. Angular uygulamalarını başlatırken önce AdminFrontEnd (localhost:4200 olarak) sonra UIFrontEnd uygulamasını çalıştırın(Görsellerin yüklenmesi için URL yapısı doğru şekilde olmalı)

## BackEnd Proje Altyapısı 

Proje altyapısı Visual Studio'da extension olarak indirilip kurgulandı. Mevcut 5 katmandan oluşan monolitik mimaride Bussiness, Core, DataAccess, Entity ve WebApi katmanları kullanılıyor. Entity katmanına eklenen sınıflar ile altyapının sağlamış olduğu CodeGenerator yardımıyla ilgili katmanlarda servisler ve diğer kod yapıları sistem tarafından oluşturuluyor.

![App Screenshot](https://github.com/frknertnt/VakifBankFinalCase/blob/main/ImageForApp/b2bdiyagram.png)

- **Bussiness**: Bu katman uygulamanın veri yönetimi, güvenlik politikaları ve yardımcı işlevler gibi çeşitli işlevsel ihtiyaçlarını karşılayacak şekilde düzenlendi. Listeleme işlemlerinde Cache kullanıldı.

- **Core**: Bu katman, uygulamanın kritik işlevselliklerini yöneten, genişletilebilirliği ve yeniden kullanılabilirliği destekleyen, genel amaçlı programlama bileşenlerinin ve servislerinin merkezi noktasıdır. 

- **DataAccess**: Bu katman, veritabanı işlemleri için özelleşmiş sınıflar barındıran ve Entity Framework üzerinden veri modelleri ile LINQ kullanarak etkileşimi sağlayan, uygulamanın veri yönetim merkezidir.

- **Entities**: Bu katman, uygulamanın veritabanı tablolarını temsil eden somut sınıflarını ve veri transfer objelerini (DTO'lar) içeren veri modelleme merkezidir. Model ve ilişkileri görselde olduğu gibidir

- **WebApi**: Bu katman, uygulamanın HTTP üzerinden dış dünya ile veri alışverişini sağlayan kontrolleri, yapılandırmaları ve modelleri barındıran sunum katmanıdır.

## FrontEnd Proje Altyapısı 

Burada Angular'ın modüler yapısının gücünden faydalanarak bir altyapı kurgulandı. Her işlevsel alan (örneğin banka hesapları, müşteriler, siparişler), kendi bileşenleri, servisleri ve modelleri ile kendi modülüne ayrılmış şekilde oluşturuldu. Componentleri besleyecek olan data akışları için servisler yazıldı. App-Routing-Module ile endpoint yönetimi sağlandı.

Admin ve bayi için iki ayrı ön yüz proje oluşturuldu. Kullanıcıların deneyimini artırmak için hazır şablonlar kullanıldı ve bootstrap ile tasarım güçlendirildi. 

## Database Altyapısı

Burada MSSQL'de Database Diagrams'ın gücünden yararlanıldı. Tablolar diagram ile oluşturulup gerekli Foreign Key ilişkileri kuruldu. Stok kontrolü için bir trigger tasarlandı ve durumu 'Sevke Hazır' olan siparişlerde otomatik stok düşme gerçekleştirildi

# Kullanım

Sistemde admin kullanıcı oluşturmak için Swagger arayüzünde Auth ile oluşturabilirsiniz. Kolay kullanıcı oluşturmak için bazı validasyonlar yorum satırı halinde bırakıldı.

Admin oluşturduktan sonra admin ara yüze giriş yapın ve ürünleri ve bayileri ekleyin. Bayilerle bağlantı ayarlamadan önce fiyat listesi tanımlayın (haftalık, aylık, yıllık olabilir) ve o liste için ürünlerinizden seçim yapın. Ürünleri ekledikten sonra bayiler kısmında  özel iskonto oranını girin.

Bayi bağlantısı oluştuktan sonra UI arayüzüne geçin ve oluşturduğunuz müşteri bilgileri giriş yapın. Özel fiyatlı ürünleri sepete ekleyip sipariş talebinde bulunduktan sonra admin tarafında sipariş yönetimi sağlayın. 

İşleme alınan siparişler müşteriye gösterilir ve ödeme gerçekleştirmesi için bir buton gözükür. Müşteri banka hesabındaki kayıtlı bilgileri ile ödeme yapabilir.

- **Bayiler**:
  - Admin tarafından sağlanan indirimli fiyatlar ile sipariş oluşturabilir ve yönetebilir.
  - Şirkete mesaj gönderebilir.
  - Ödeme işlemlerini yönetebilir.
  - Sepete eklediği ürünü stok durumuna göre artırıp azaltabilir.

  ![App Screenshot](https://via.placeholder.com/468x300?text=App+Screenshot+Here)

- **Admin**:
  - Tüm kullanıcı işlemlerini yönetir. (Bayi şifre güncelleme dahil)
  - Sipariş onayı ve reddi verebilir.
  - Raporları görüntüleyebilir ve indirebilir.
  - Mesajlaşma modülü üzerinden iletişim kurabilir.
  - Banka hesaplarını yönetebilir.
  
  ![App Screenshot](https://github.com/frknertnt/VakifBankFinalCase/blob/main/ImageForApp/order.png)

### Anlık Mesajlaşma

Şirket ve bayi arasında anlık iletişimi sağlayan mesajlaşma sistemi bulunmaktadır

![App Screenshot](https://github.com/frknertnt/VakifBankFinalCase/blob/main/ImageForApp/chat.gif)

### Ürün Ana Resim Seçimi

Ürün fotoğrafları üzerinden ana resim seçimi yapılabilir

![App Screenshot](https://github.com/frknertnt/VakifBankFinalCase/blob/main/ImageForApp/anaresim.gif)

### API Endpoints

- Login yönetimi: `GET, POST /api/auth`
- Admin yönetimi: `GET, POST /api/users`
- Bayi yönetimi: `GET, POST /api/customers`
- Ürün yönetimi: `GET, POST /api/products`
- Sipariş yönetimi: `GET, POST /api/orders`
- Sepet yönetimi: `GET, POST /api/baskets`
- Ödeme işlemleri: `POST /api/accounttransactions`
- Mesajlaşma: `GET, POST /api/messages`

