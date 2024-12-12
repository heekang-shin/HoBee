package vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class CategoryVO {
	private int category_num;
	private String category_name;
}
