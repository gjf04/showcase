package com.admin.service.impl.system;

import com.admin.dao.system.AttachmentDao;
import com.admin.dao.system.DepartmentDao;
import com.admin.entity.system.Attachment;
import com.admin.entity.system.Attachment;
import com.admin.service.system.AttachmentService;
import com.gao.common.ServiceResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * Created by GaoJingFei on 2017/11/13.
 */
@Slf4j
@Service
public class AttachmentServiceImpl implements AttachmentService {
    @Autowired
    private AttachmentDao attachmentDao;

    @Override
    public List<Attachment> getByRelateId(Long relateId) {
        return attachmentDao.getByRelateId(relateId);
    }
    
    @Override
    public ServiceResult<Attachment> createAttachment(Attachment attachment) {
        ServiceResult<Attachment> executeResult = new ServiceResult<Attachment>();
        attachment.setCreatedAt(new Date());
        attachment.setUpdatedAt(new Date());
        attachmentDao.insert(attachment);
        executeResult.setResult(attachment);
        return executeResult;
    }
    @Override
    public ServiceResult<Attachment> updateAttachment(Attachment attachment) {
        ServiceResult<Attachment> executeResult = new ServiceResult<Attachment>();
        Attachment dbAttachment = attachmentDao.getById(attachment.getId());
        if(dbAttachment == null){
            executeResult.setMessage("该附件不存在或已经被删除。");
            return executeResult;
        }
        attachment.setUpdatedAt(new Date());
        attachmentDao.update(attachment);
        return executeResult;
    }

    @Override
    public Attachment getAttachmentById(Long id) {
        return attachmentDao.getById(id);
    }
}
