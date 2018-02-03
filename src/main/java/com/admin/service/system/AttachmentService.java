package com.admin.service.system;
import com.admin.entity.system.Attachment;
import com.admin.entity.system.Attachment;
import com.gao.common.PagerInfo;
import com.gao.common.ServiceResult;

import java.util.List;
import java.util.Map;

/**
 * Created by GaoJingFei on 2017/11/13.
 */

public interface AttachmentService {
    /**
     * 根据relateId查询
     * @param relateId
     * @return
     */
    public List<Attachment> getByRelateId(Long relateId);
    /**
     * 创建
     * @param attachment
     */
    public ServiceResult<Attachment> createAttachment(Attachment attachment);

    /**
     * 更新
     * @param attachment
     */
    public ServiceResult<Attachment> updateAttachment(Attachment attachment);

    /**
     * 通过id获取
     * @param id
     * @return
     */
    public Attachment getAttachmentById(Long id);
}
