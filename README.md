
# ZooManagementApp
--
- ZooManagementApp, hayvanat bahçesi ismi, logosu,  su limiti ve bütçe ile hayvanat bahçesi oluşturulan bir uygulamadır. Uygulamadan, hayvanat bahçesine bakıcı ve hayvanlar eklenebilir, hayvanlara bakıcı atanabilir, hayvanlar ve çalışanlar listelenebilir, hayvan sesleri dinlenebilir, su limiti güncellenebilir, bütçeye gelir & gider eklenebilir ve bütçeden maaşlar ödenebilir.

### 1. Hayvanat Bahçesi Kayıt
<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/96587699/202917847-591b1a43-7780-4a6d-905c-9eb8c4e969d7.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917685-c211e6bd-6f71-40c0-916e-e4e2c45235d9.png" alt="drawing" width="250"/></td>  
</tr>
</table>
</div>

- Hayvanat bahçesi logosu ImagePickerController ile galeriden seçilir.
- İsim, bütçe ve su limiti bilgileriyle hayvanat bahçesi oluşturulur.

### 2. Şirket Detay
<div align="center">
<td><img src="https://user-images.githubusercontent.com/96587699/202917688-d114df2d-2e2d-4651-9b2b-0108dfae4539.png" alt="drawing" width="250"/></td>  
</div>

- Yukarıdaki görseldeki gibi hayvanat bahçesinin bilgilerine ulaşılabilir.
- Bakıcı sayısı ve maaşları çalışan eklenince güncellenir.
- Kalan su limiti hayvan ekledikçe azalır.
- Bütçeye gelir gider eklemesi yapılabilir.
- Bakıcı maaşları ödenebilir.
- Su limiti değiştirilebilir veya istenen miktarda arttırılabilir.
- Hayvan ve Bakıcı listeleme, yeni bakıcı ekleme ve yeni hayvan ekleme sayfalarına geçiş yapılabilir.

### 3. Çalışan Ekleme
<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/96587699/202917692-f220e71f-3082-4b2c-b02b-63c70da03a02.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917696-eb500c33-28b5-40c3-ada1-de281cb822f4.png" alt="drawing" width="250"/></td>  
</tr>
</table>
</div>

- Çalışan ismi, id'si ve yaşı girildikten sonra maaş otomatik olarak hesaplanır. Salary text field etkinleştirilmediği için sadece görüntüleme yapılabilir.
- Aynı id ye sahip çalışan eklenemez.

### 4. Hayvan Ekleme
<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/96587699/202917703-0c8a53a2-050d-4a22-a6a6-78f72c8fdd01.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917707-1e5867d8-ed71-4260-b5fd-a05a01213e40.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917709-012ccd26-5a2d-4bf2-bfd9-4a13f965570b.png" alt="drawing" width="250"/></td>  
</tr>
</table>
</div>

- Hayvanat bahçesine bakıcı eklenmeden hayvan eklemesi yapılamaz.
- Hayvan listesi içinden pickerView ile hayvan seçimi yapılır. Picker açıldığında ilk hayvan default olarak seçilir.
- Hayvanların su limitleri önceden tanımlanmıştır. Water consumption textField etkinsizleştirildiği için değiştirilemez. Sadece görüntülenir.
- Hayvanat bahçesine önceden eklenen bakıcılar pickerView ile seçilir. Default olarak ilk bakıcı seçilir.
- Önceden tanımlanmış bir hayvan increase animal count butonu ile arttırılabilir.
- Önceden tanımlanmış bir hayvan seçildiğinde bakıcısı otomatik gelir ve textField'ı etkinsizleştirilir.
- Aynı hayvana farklı bakıcı atanamaz.

### 5. Hayvan & Bakıcı Listeleme
<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/96587699/202917710-10229c3c-f1af-4c48-b5b5-b93ea2ad8263.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917713-43b97186-598e-4731-b293-7eadeef64257.png" alt="drawing" width="250"/></td>  
</tr>
</table>
</div>

- Segmented Control ile hayvan ve bakıcı listeleme tableview'leri arasında geçiş yapılabilir.
- Hayvanlar, resimleriyle, isim, su tüketimi, sayı ve bakıcı bilgileriyle listelenir.
- Hoperlör butonuna tıklandığında hayvanın sesi dinlenebilir.
- Bakıcılar isim, id, yaş ve sorumlu oldukları hayvanlar ile listelenir.
- Bakıcı cell'i içinde ayrı bir tableView içerisinde hayvanlar listelenir.

### 5. Uyarılar
<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/96587699/202917716-bce9cd99-12b3-4c81-82b8-6426bba291e8.png" alt="drawing" width="250"/></td>   
<td><img src="https://user-images.githubusercontent.com/96587699/202917719-f283a98e-5b3a-4fd1-a06a-6d8382f0c079.png" alt="drawing" width="250"/></td>  
<td><img src="https://user-images.githubusercontent.com/96587699/202917721-f532bccf-6f7c-468d-afab-0fc289340146.png" alt="drawing" width="250"/></td>  
</tr>
</table>
</div>

Bazı örnek uyarılar yukarıdaki görsellerde mevcuttur.
#### Diğer Uyarılar

- **Boşluklar doldurulmadığında veya hatalı doldurulduğunda:** "Please make sure you fill in the blanks correctly."
-  **Numeric alana değer girilmediğinde veya non numeric değer girildiğinde:** "Please make sure you enter a value. The value you enter must be numeric."
- **Hayvanat bahçesinde bakıcı yokken hayvan eklenmek istendiğinde:** "Before adding new animal you should add at least one keeper."
 - **Yaş ve id non numeric girildiğinde:** "Age and id should be integer."
- **Hayvan yokken hayvan sayısı eklenmek istendiğinde:** "There is no animal in the zoo. Please use Create Animal button."
- **Aynı id'li çalışan eklenmek istendiğinde:** "There is already a keeper with id: \(keeper.keeperId). Please try another id."
- **Daha önce eklenen bir hayvan yeniden oluşturulmak istenirse:** "There is already an animal with breed: \(animalBreed). Please click Increase Animal Count button."
- **Sayısı arttırılmak istenen hayvan daha önce oluşturulmadıysa:** "Breed: \(animalBreed) animal is not previosly defined. Please click Create Animal button."
- **Eklemek istenen hayvan sayısında su limiti yeterli değilse:** "Remaining water limit of zoo is not enough to get \(count) \(animalBreed). Please increase the water limit at least \((waterConsumption * Double(count) - remainingLimit).formattedWithSeparator)."
- **Bütçe gider eklemeye yetersiz ise:** "There is not enough money to pay expense. Please add income to budget case."
- **Çalışan maaşları ödendiğinde:** "\(totalSalary.formattedWithSeparator)₺ keeper salaries are paid. Remaining budget: \(budget.formattedWithSeparator)₺."
- **Maaşlara yeterli bütçe yoksa:** "There is not enough money to pay salaries. Please add income to budget case."
- **Çalışan yokken maaş ödenmek istendiğinde:** "There is no keeper to pay salary."
