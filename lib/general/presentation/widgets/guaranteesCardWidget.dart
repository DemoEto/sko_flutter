import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/models/guaranteesModel.dart';

class GuaranteesCard extends StatelessWidget {
  final GuaranteesModel guarantee;

  const GuaranteesCard({Key? key, required this.guarantee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String whoareu = "";
    if (guarantee.title == 'whocallyou'){
      whoareu = context.tr("Guarantors");
    }else if (guarantee.title == 'youcallwho') {
      whoareu = context.tr("Borrower");
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [guarantee.color[400]!, guarantee.color[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: guarantee.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // ไอคอน
                    // Container(
                    //   padding: const EdgeInsets.all(12),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.2),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Icon(
                    //     account.icon,
                    //     color: Colors.white,
                    //     size: 28,
                    //   ),
                    // ),
                    // const SizedBox(width: 16),

                    //-- Head
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.tr('ContractNo')} :',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${context.tr('LoanType')} :',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${context.tr('LoanBalance')} :',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${context.tr('LastPeriod')} :',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                    //-- Body
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          guarantee.contractno,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guarantee.loantype,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guarantee.formattedBalance,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guarantee.lastperiod,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //     horizontal: 8,
                        //     vertical: 2,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.2),
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Text(
                        //     context.tr("ViewDetail"),
                        //     style: TextStyle(color: Colors.white, fontSize: 10),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 0.9, // ⭐ 80%
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                Text(
                  whoareu,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("ชื่อ - นามสกุล",style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                  ),),
                      Text('${context.tr("MemberNo")} : ${guarantee.memberno}',style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,

                  ),),
                    ],)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
