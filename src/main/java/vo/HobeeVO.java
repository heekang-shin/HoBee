package vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class HobeeVO {
	private int hb_idx, hb_price, num_of_p, user_id, hb_tot_num, category_num;
	private String hb_title, s_image, l_image, in_image1, in_image2, hb_content,
				   hb_date, hb_write_date;
}
