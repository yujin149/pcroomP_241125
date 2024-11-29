package com.pcroom.dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.pcroom.dto.ReserveDTO;
import com.pcroom.util.DatabaseUtil;

public class ReserveDAO {
    
    // 좌석 예약하기
    public boolean reserveSeat(ReserveDTO reserve) {
        String SQL = "INSERT INTO reserve (seat, user_id, time, hours) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            
            pstmt.setInt(1, reserve.getSeat());
            pstmt.setString(2, reserve.getUserId());
            pstmt.setTimestamp(3, Timestamp.valueOf(LocalDateTime.now()));
            pstmt.setInt(4, reserve.getHours());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 예약 취소하기
    public boolean cancelReservation(int seat) {
        String SQL = "DELETE FROM reserve WHERE seat = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            
            pstmt.setInt(1, seat);
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 모든 예약 정보 조회
    public List<ReserveDTO> getAllReservations() {
        List<ReserveDTO> reservations = new ArrayList<>();
        String SQL = "SELECT r.seat, r.user_id, u.name, u.tel, r.time, r.hours " +
                    "FROM reserve r JOIN user u ON r.user_id = u.user_id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                ReserveDTO dto = new ReserveDTO();
                dto.setSeat(rs.getInt("seat"));
                dto.setUserId(rs.getString("user_id"));
                dto.setUserName(rs.getString("name"));
                dto.setUserTel(rs.getString("tel"));
                dto.setTime(rs.getTimestamp("time").toLocalDateTime());
                dto.setHours(rs.getInt("hours"));
                reservations.add(dto);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reservations;
    }
    
    // 특정 좌석 예약 정보 조회
    public ReserveDTO getReservationBySeat(int seat) {
        String SQL = "SELECT r.seat, r.user_id, u.name, u.tel, r.time, r.hours " +
                    "FROM reserve r JOIN user u ON r.user_id = u.user_id " +
                    "WHERE r.seat = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            
            pstmt.setInt(1, seat);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ReserveDTO dto = new ReserveDTO();
                    dto.setSeat(rs.getInt("seat"));
                    dto.setUserId(rs.getString("user_id"));
                    dto.setUserName(rs.getString("name"));
                    dto.setUserTel(rs.getString("tel"));
                    dto.setTime(rs.getTimestamp("time").toLocalDateTime());
                    dto.setHours(rs.getInt("hours"));
                    return dto;
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 사용자 ID로 예약 확인
    public boolean checkUserReservation(String userId) {
        String SQL = "SELECT COUNT(*) FROM reserve WHERE user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 검색 기능
    public List<ReserveDTO> searchReservations(String searchType, String keyword) {
        List<ReserveDTO> reservations = new ArrayList<>();
        String SQL = "SELECT r.seat, r.user_id, u.name, u.tel, r.time, r.hours " +
                    "FROM reserve r JOIN user u ON r.user_id = u.user_id ";
        
        if (!"all".equals(searchType) && keyword != null && !keyword.trim().isEmpty()) {
            if ("seat".equals(searchType)) {
                SQL += "WHERE r.seat = ?";
            } else if ("user_id".equals(searchType)) {
                SQL += "WHERE r.user_id LIKE ?";
            }
        }
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(SQL)) {
            
            if (!"all".equals(searchType) && keyword != null && !keyword.trim().isEmpty()) {
                if ("seat".equals(searchType)) {
                    pstmt.setInt(1, Integer.parseInt(keyword));
                } else if ("user_id".equals(searchType)) {
                    pstmt.setString(1, "%" + keyword + "%");
                }
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ReserveDTO dto = new ReserveDTO();
                    dto.setSeat(rs.getInt("seat"));
                    dto.setUserId(rs.getString("user_id"));
                    dto.setUserName(rs.getString("name"));
                    dto.setUserTel(rs.getString("tel"));
                    dto.setTime(rs.getTimestamp("time").toLocalDateTime());
                    dto.setHours(rs.getInt("hours"));
                    reservations.add(dto);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reservations;
    }
}