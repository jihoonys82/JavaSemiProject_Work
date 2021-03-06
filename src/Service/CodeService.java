package Service;

import java.util.ArrayList;

import dao.CodeDao;
import dao.CodeDaoImpl;
import dto.CodeCategoryDto;
import dto.CodeDto;
import dto.TechDto;

public class CodeService {
	
	private CodeDao dao = new CodeDaoImpl();
	
	public ArrayList<CodeCategoryDto> getAllCategory(String userEmail){	
		return dao.getAllCategory(userEmail);
	}
	
	public int getAllCount(String userEmail) {
		return dao.getAllCount(userEmail);
	}
	
	public ArrayList<CodeDto> getCodeList(String userEmail) {
		return dao.getCodeList(userEmail);
	}
	
	public ArrayList<CodeDto> getCodeList(int categoryNo, String userEmail){
		return dao.getCodeList(categoryNo, userEmail);
	}

	public void createCategory(String categoryName, String userEmail) {
		dao.createCategory(categoryName, userEmail);
	}
	
	public void deleteCategory(int categoryNo) {
		dao.deleteCategory(categoryNo);
	}

	public CodeDto getCode(int codeNo) {
		return dao.getCode(codeNo);
	}

	public ArrayList<TechDto> getAllTechList() {
		return dao.getAllTechList();
	}
	
	public String getCategoryName(int categoryNo) {
		return dao.getCategoryName(categoryNo);
	}

	public int getCategoryNo(String inputCategory, String userEmail) {
		return dao.getCatgoryNo(inputCategory, userEmail);
	}

	public void setNewCode(CodeDto cdto) {
		int codeNo = dao.setNewCode(cdto);
//		dao.setTech(cdto, codeNo);
	}

	public void deleteCode(int codeNo) {
		dao.deleteCode(codeNo);	
	}
}
