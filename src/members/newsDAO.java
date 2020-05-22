package members;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class newsDAO {
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String user = "java";
	private String pwd="1234";
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public newsDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//페이지 목록 선택에 따른 게시글 변화
	public ArrayList<newsDTO> list(int start) {
		int firstNum = 0; int lastNum = 0;
		String sql = "select B.* from(select rownum rn, A.* from(" + 
				"select * from test_board order by id desc)A)B" + 
				" where rn between ? and ?";
		ArrayList<newsDTO> listDto = new ArrayList<newsDTO>();
		
		if(start==0 || start==1) {firstNum = 1;	lastNum = 5;}
		else {firstNum = (5*(start-1))+1;	lastNum = 5*start;}
		
		try{
			con = DriverManager.getConnection(url, user, pwd);
			ps = con.prepareStatement(sql);
			ps.setInt(1, firstNum);
			ps.setInt(2, lastNum);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				newsDTO dto = new newsDTO();
				
				dto.setId(rs.getInt("id"));
				dto.setHit(rs.getInt("hit"));
				dto.setIdgroup(rs.getInt("idgroup"));
				dto.setIndent(rs.getInt("indent"));
				dto.setStep(rs.getInt("step"));
				
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setSavedate(rs.getTimestamp("savedate"));
				
				listDto.add(dto);
			}			
		}catch (Exception e) {e.printStackTrace();}
		return listDto;
	}

	//페이지 목록 계산을 위한 총 게시물 갯수
	public int getTotalPage() {
		String sql = "select count(*) from test_board";
		int totalPage = 0;
		try{
			con = DriverManager.getConnection(url, user, pwd);
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) totalPage = rs.getInt(1);
			
		}catch (Exception e) {e.printStackTrace();}
		return totalPage;
	}
	
	//페이지 목록
	public int page(int totalPage) {
		int pageResult = totalPage / 5;
		if(totalPage % 5 != 0) ++pageResult;
		return pageResult;
	}
	
	//글 내용 보기
	public newsDTO contentView(String id) {
		upHit(id);	//조회수를 올려줄 메소드
		
		String sql = "select * from test_board where id=?";
		newsDTO dto = new newsDTO();
		
		try {
			con = DriverManager.getConnection(url, user, pwd);
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getInt("id"));
				dto.setHit(rs.getInt("hit"));
				dto.setIdgroup(rs.getInt("idgroup"));
				dto.setIndent(rs.getInt("indent"));
				dto.setStep(rs.getInt("step"));
				
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setSavedate(rs.getTimestamp("savedate"));
			}

		} catch (Exception e) {e.printStackTrace();}
		return dto;
	}
	
	//조회수
	public void upHit(String id) {
		String sql = "update test_board set hit=hit+1 where id="+id;
		try {
			con = DriverManager.getConnection(url, user, pwd);
			ps = con.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {e.printStackTrace();}
	}
}
