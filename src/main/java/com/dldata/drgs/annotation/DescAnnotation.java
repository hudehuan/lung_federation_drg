package com.dldata.drgs.annotation;

import java.lang.annotation.*;

/**
 * Created by zhangyy on 2017-04-24.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE,ElementType.FIELD,ElementType.METHOD})
@Documented
public @interface DescAnnotation {

    String value() default "";

    int num() default 100;

    String[] address() default {};
}
